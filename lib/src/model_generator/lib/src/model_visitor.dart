import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:collection/collection.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/options.dart';
import 'package:model_generator/src/parameter.dart';
import 'package:model_generator/src/validator.dart';
import 'package:model_generator_annotation/model_generator_annotation.dart'
    show Default, GenerateModel;
import 'package:source_gen/source_gen.dart';

enum SyntaxRequirements {
  extendsRequiredClass,
  hasPrivateConstructor,
  hasFactoryConstructor,
}

class ModelVisitor extends SimpleElementVisitor<void> {
  late Model visitedModel;

  final List<SyntaxRequirements> missingRequirements = List.from(SyntaxRequirements.values);

  Model getModelFromElement({
    required Element element,
    required Options options,
  }) {
    visitedModel = Model(
      annotatedElement: element,
      options: options,
    );

    Validator().assertValidAnnotatedElement(element, visitedModel);
    visitClassElement(element as ClassElement);
    return visitedModel;
  }

  @override
  void visitClassElement(ClassElement element) {
    /// Check if the annotated class extends the required model.
    if (visitedModel.options.mustExtend == null) {
      missingRequirements.remove(SyntaxRequirements.extendsRequiredClass);
    } else {
      for (final type in element.allSupertypes) {
        if (type.getDisplayString(withNullability: false) == visitedModel.options.mustExtend) {
          missingRequirements.remove(SyntaxRequirements.extendsRequiredClass);
        }
      }
    }

    visitedModel.className = element.name;

    element.visitChildren(this);
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    /// Private const constructor.
    if (element.isConst && element.isPrivate && element.name == '_' && element.parameters.isEmpty) {
      missingRequirements.remove(SyntaxRequirements.hasPrivateConstructor);
    }

    /// Public factory constructor.
    if (element.isConst && element.isPublic && element.isFactory) {
      missingRequirements.remove(SyntaxRequirements.hasFactoryConstructor);

      /// Must be called so that visitParameterElement is called.
      element.visitChildren(this);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    Validator().assertValidParameter(element, visitedModel);
    visitedModel.parameters.add(
      Parameter(
        defaultValue: element.defaultValue,
        type: parseTypeSource(element) ?? '',
        name: element.name,
        isRequired: element.isNotOptional,
        isDartCoreList: element.type.isDartCoreList,
        isDartCoreMap: element.type.isDartCoreMap,
        isDartCoreSet: element.type.isDartCoreSet,
        isNullable: element.type.nullabilitySuffix == NullabilitySuffix.question,
        hasGeneratedModifier: element.hasGeneratedModifier,
      ),
    );
  }
}

extension DefaultValue on ParameterElement {
  static const _typeChecker = TypeChecker.fromRuntime(GenerateModel);

  bool get hasGeneratedModifier {
    return type.element != null &&
        type.element is ClassElement &&
        (_typeChecker.firstAnnotationOf(type.element!))
                ?.getField('shouldGenerateModifier')
                ?.toBoolValue() ==
            true;
  }

  /// This code is from the Freezed package: https://pub.dev/packages/freezed
  /// Returns the sources of the default value associated with a `@Default`,
  /// or `null` if no `@Default` are specified.
  String? get defaultValue {
    const matcher = TypeChecker.fromRuntime(Default);

    for (final meta in metadata) {
      final obj = meta.computeConstantValue()!;
      if (matcher.isExactlyType(obj.type!)) {
        final source = meta.toSource();
        final res = source.substring('@Default('.length, source.length - 1);
        final needsConstModifier = !declaration.type.isDartCoreString &&
            !res.trimLeft().startsWith('const') &&
            (res.contains('(') || res.contains('[') || res.contains('{'));

        if (needsConstModifier) {
          return 'const $res';
        } else {
          return res;
        }
      }
    }
    return null;
  }
}

/// This code is from the Freezed package: https://pub.dev/packages/freezed
String? parseTypeSource(VariableElement element) {
  final String type = element.type.getDisplayString(withNullability: true);

  if (type.contains('dynamic') && element.nameOffset > 0) {
    final source = element.source!.contents.data.substring(0, element.nameOffset);
    if (element.type.element != null &&
        element.type.isDynamic &&
        element.type.element!.isSynthetic) {
      final match = RegExp(r'(\w+\??)\s+$').firstMatch(source);
      return match?.group(1);
    } else if (element.type.element != null) {
      final match = RegExp(r'(\w+<.+?>\??)\s+$').firstMatch(source);
      return match?.group(1) ?? type;
    }
  }

  return resolveFullTypeStringFrom(
    element.library!,
    element.type,
    withNullability: true,
  );
}

/// This code is from the Freezed package: https://pub.dev/packages/freezed
Element? _getElementForType(DartType type) {
  if (type.element != null) {
    return type.element;
  }
  return type.alias?.element;
}

/// This code is from the Freezed package: https://pub.dev/packages/freezed
/// Renders a type based on its string + potential import alias
String resolveFullTypeStringFrom(
  LibraryElement originLibrary,
  DartType type, {
  required bool withNullability,
}) {
  final owner = originLibrary.prefixes.firstWhereOrNull(
    (e) {
      final librariesForPrefix = e.library.getImportsWithPrefix(e);

      return librariesForPrefix.any((l) {
        return l.importedLibrary!.anyTransitiveExport((library) {
          return library.id == _getElementForType(type)?.library?.id;
        });
      });
    },
  );

  String? displayType = type.getDisplayString(withNullability: withNullability);

  // The parameter is a typedef in the form of
  // SomeTypedef typedef
  //
  // In this case the analyzer would expand that typedef using getDisplayString
  // For example for:
  //
  // typedef SomeTypedef = Function(String);
  //
  // it would generate:
  // 'dynamic Function(String)'
  //
  // Instead of 'SomeTypedef'
  if (type is FunctionType && type.alias?.element != null) {
    displayType = type.alias!.element.name;
    if (type.alias!.typeArguments.isNotEmpty) {
      displayType += '<${type.alias!.typeArguments.join(', ')}>';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      displayType += '?';
    }
  }

  if (owner != null) {
    return '${owner.name}.$displayType';
  }

  return displayType;
}

/// This code is from the Freezed package: https://pub.dev/packages/freezed
extension LibraryHasImport on LibraryElement {
  LibraryElement? findTransitiveExportWhere(
    bool Function(LibraryElement library) visitor,
  ) {
    if (visitor(this)) return this;

    final visitedLibraries = <LibraryElement>{};
    LibraryElement? visitLibrary(LibraryElement library) {
      if (!visitedLibraries.add(library)) return null;

      if (visitor(library)) return library;

      for (final export in library.exportedLibraries) {
        final result = visitLibrary(export);
        if (result != null) return result;
      }

      return null;
    }

    for (final import in exportedLibraries) {
      final result = visitLibrary(import);
      if (result != null) return result;
    }

    return null;
  }

  bool anyTransitiveExport(
    bool Function(LibraryElement library) visitor,
  ) {
    return findTransitiveExportWhere(visitor) != null;
  }
}
