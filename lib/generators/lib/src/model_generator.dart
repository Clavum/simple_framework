import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/src/annotation.dart';
import 'package:generators/src/model.dart';
import 'package:generators/src/parameter.dart';
import 'package:generators/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

const String _constructorBypassedError = '_constructorBypassedError';

class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  /// Oddly, neither the Generator nor Builder classes allow a convenient way
  /// of defining a single object per file. This String keeps track of the file
  /// path of the last file that generated the header content to avoid
  /// outputting it more than once per file.
  String generatedHeaderFor = '';

  @override
  String generateForAnnotatedElement(
      Element element,
      ConstantReader annotation,
      BuildStep buildStep,
      ) {
    final String annotationName = annotation.read('annotationName').stringValue;
    final bool shouldGenerateMerge =
        annotation.read('shouldGenerateMerge').boolValue;
    final bool addErrorsParameter =
        annotation.read('addErrorsParameter').boolValue;
    final bool shouldGenerateGetter =
        annotation.read('shouldGenerateGetter').boolValue;
    final String? mustExtend = annotation.read('mustExtend').stringValue;

    final Visitor visitor = Visitor(
      annotationName: annotationName,
      mustExtend: mustExtend,
    );
    final StringBuffer buffer = StringBuffer();
    final Model visitedModel = visitor.getModelFromElement(element: element);

    if (visitor.missingRequirements.isNotEmpty) {
      throwMissingSyntaxRequirementsException(
        visitedModel,
        visitor.missingRequirements,
        mustExtend,
      );
    }

    if (visitedModel.invalidParameters().isNotEmpty) {
      _throwInvalidParameterException(visitedModel);
    }

      /// Add the errors parameter.
    if (addErrorsParameter) {
      visitedModel.parameters.insert(
        0,
        const Parameter(
          name: 'errors',
          defaultValue: 'const []',
          type: 'List<EntityFailure>',
          isRequired: false,
        ),
      );
    }

    /// Only build the header content if it hasn't been built for this file yet.
    if (generatedHeaderFor != buildStep.inputId.path) {
      generatedHeaderFor = buildStep.inputId.path;
      buffer.writeln(fileHeaderInformation());
    }

    String mixinString = MixinGenerator.generate(
      visitedModel,
      shouldGenerateMerge,
    );
    buffer.writeln(mixinString);

    String mainClassString = MainClassGenerator.generate(
      visitedModel,
      shouldGenerateMerge,
    );
    buffer.writeln(mainClassString);

    String abstractClassString = AbstractClassGenerator.generate(visitedModel);
    buffer.writeln(abstractClassString);

    if (shouldGenerateGetter) {
      generateGetter(visitedModel, buffer);
    }

    return buffer.toString();
  }

  String fileHeaderInformation() {
    return '''
final $_constructorBypassedError = UnsupportedError(
    'A generated model\\'s constructor was bypassed by another constructor.');

''';
  }

  void generateGetter(Model model, StringBuffer buffer) {
    buffer.write('${model.className} get ${model.camelCaseName} ');
    buffer.writeln('=> Repository().get(const ${model.className}());');
  }
}

class MixinGenerator {
  static String generate(Model model, bool shouldGenerateMerge) {
    final StringBuffer mergeBuffer = StringBuffer();
    if (shouldGenerateMerge) {
      mergeBuffer.writeln(
        '''
${model.className} merge({
    ${model.nullableParameterList()}
  }) {
    throw $_constructorBypassedError;
  }
''',
      );
    }

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin ${model.mixinName} {
  ${model.getterList('throw $_constructorBypassedError')}
  ${mergeBuffer.toString()}

  List<Object?> get props => throw $_constructorBypassedError;
}

''';
  }
}

class MainClassGenerator {
  static String generate(Model model, bool shouldGenerateMerge) {
    String generatedWarning = '';
    if (model.parameters.isNotEmpty) {
      generatedWarning = '// GENERATED CODE - DO NOT MODIFY BY HAND';
    }

    final StringBuffer mergeBuffer = StringBuffer();
    if (shouldGenerateMerge) {
      mergeBuffer.writeln(
        '''
// GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  ${model.abstractClassName} merge({
    ${model.nullableParameterList()}
  }) {
    return ${model.abstractClassName}(
      ${model.mergeFieldsList()}
    );
  }

''',
      );
    }

    String maybeLeftBrace = model.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = model.parameters.isNotEmpty ? '}' : '';

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class ${model.mainClassName} extends ${model.abstractClassName} {
  const ${model.mainClassName}($maybeLeftBrace
    ${model.concreteParameterList()}
  $maybeRightBrace) : super._();

  $generatedWarning
  ${model.parameterOverrides()}

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        ${model.parametersWithCommas()}
      ];

  ${mergeBuffer.toString()}
  @override
  Type get runtimeType => ${model.className};
}

''';
  }
}

class AbstractClassGenerator {
  static String generate(Model model) {
    String maybeLeftBrace = model.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = model.parameters.isNotEmpty ? '}' : '';

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class ${model.abstractClassName} extends ${model.className} {
  const factory ${model.abstractClassName}($maybeLeftBrace
    ${model.redirectedParameterList()}
  $maybeRightBrace) = ${model.mainClassName};

  const ${model.abstractClassName}._() : super._();

  ${model.getterList()}
}

''';
  }
}

void throwMissingSyntaxRequirementsException(
  Model model,
  List<SyntaxRequirements> missingRequirements,
  String? mustExtend,
) {
  StringBuffer errorBuffer = StringBuffer();

  errorBuffer.writeln('Invalid syntax for generated model: ${model.className}');

  if (model.className.isEmpty) {
    model.className = 'ClassName';
  }

  if (missingRequirements.contains(SyntaxRequirements.extendsRequiredClass)) {
    errorBuffer.writeln();
    errorBuffer.writeln('${model.className} must extend $mustExtend');
  }
  if (missingRequirements.contains(SyntaxRequirements.hasPrivateConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a const private constructor:');
    errorBuffer.writeln('const ${model.className}_.();');
  }
  if (missingRequirements.contains(SyntaxRequirements.hasFactoryConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a const factory constructor:');
    errorBuffer.writeln(
      '''
const factory ${model.className}({
  ...your fields
}) = _${model.className};
''',
    );
  }

  throw Exception(errorBuffer.toString());
}

void _throwInvalidParameterException(Model model) {
  StringBuffer invalidParametersBuffer = StringBuffer();
  for (var parameter in model.invalidParameters()) {
    invalidParametersBuffer.writeln(parameter.name);
  }

  throw Exception(
    '''
Invalid syntax for generated model: ${model.className}

Every parameter's syntax must either be in one of these three forms:

1. required Type parameterName
2. @Default(defaultValue) Type parameterName
3. Type? parameterName

Parameters with invalid syntax:
${invalidParametersBuffer.toString()}
''',
  );
}