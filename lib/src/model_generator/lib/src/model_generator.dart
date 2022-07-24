import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/model_visitor.dart';
import 'package:model_generator/src/parameter.dart';
import 'package:model_generator_annotation/model_generator_annotation.dart' show GenerateModel;
import 'package:source_gen/source_gen.dart';

class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final String annotationName = annotation.read('annotationName').stringValue;
    final bool shouldGenerateMerge = annotation.read('shouldGenerateMerge').boolValue;
    final bool addErrorsParameter = annotation.read('addErrorsParameter').boolValue;
    final String? mustExtend = annotation.read('mustExtend').stringValue;

    final ModelVisitor visitor = ModelVisitor(
      annotationName: annotationName,
      mustExtend: mustExtend,
    );
    final StringBuffer buffer = StringBuffer();
    final Model visitedModel = visitor.getModelFromElement(element: element);

    if (visitor.missingRequirements.isNotEmpty) {
      _throwMissingSyntaxRequirementsException(
        visitedModel,
        visitor.missingRequirements,
        mustExtend,
        element,
        annotationName,
      );
    }

    if (visitedModel.invalidParameters().isNotEmpty) {
      _throwInvalidParameterException(visitedModel, element);
    }

    buffer.writeln(bypassError(visitedModel));

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

    return buffer.toString();
  }

  String bypassError(Model model) {
    return '''
final ${model.bypassError} = UnsupportedError(
  '${model.className}\\'s constructor was bypassed by another constructor.',
);

''';
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
    throw ${model.bypassError};
  }
''',
      );
    }

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin ${model.mixinName} {
  ${model.getterList('throw ${model.bypassError}')}
  ${mergeBuffer.toString()}

  List<Object?> get props => throw ${model.bypassError};
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

void _throwMissingSyntaxRequirementsException(
  Model model,
  List<SyntaxRequirements> missingRequirements,
  String? mustExtend,
  Element element,
  String annotationName,
) {
  StringBuffer errorBuffer = StringBuffer();

  errorBuffer.writeln('Invalid syntax for generated model: ${model.className}');

  if (missingRequirements.contains(SyntaxRequirements.extendsRequiredClass)) {
    errorBuffer.writeln();
    errorBuffer.write('${model.className} must extend $mustExtend');
    errorBuffer.writeln(' if it is annotated with $annotationName.');
  }
  if (missingRequirements.contains(SyntaxRequirements.hasPrivateConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a valid const private constructor. You must have:');
    errorBuffer.writeln('const ${model.className}._();');
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

  throw InvalidGenerationSourceError(
    errorBuffer.toString(),
    element: element,
  );
}

void _throwInvalidParameterException(Model model, Element element) {
  StringBuffer invalidParametersBuffer = StringBuffer();
  for (var parameter in model.invalidParameters()) {
    invalidParametersBuffer.writeln(parameter.name);
  }

  throw InvalidGenerationSourceError(
    '''
Invalid syntax for generated model: ${model.className}

Every parameter's syntax must either be in one of these forms:

1. required Type parameterName
2. @Default(defaultValue) Type parameterName
3. Type? parameterName

Parameters with invalid syntax:
${invalidParametersBuffer.toString()}
''',
    element: element,
  );
}
