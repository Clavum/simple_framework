import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/model_visitor.dart';
import 'package:model_generator/src/options.dart';
import 'package:model_generator/src/templates/mixin_template.dart';
import 'package:model_generator/src/templates/concrete_template.dart';
import 'package:model_generator/src/templates/abstract_template.dart';
import 'package:model_generator/src/templates/modifier_template.dart';
import 'package:model_generator_annotation/model_generator_annotation.dart' show GenerateModel;
import 'package:source_gen/source_gen.dart';

class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ModelVisitor visitor = ModelVisitor();
    final StringBuffer buffer = StringBuffer();
    final Model visitedModel = visitor.getModelFromElement(
      element: element,
      options: Options.fromAnnotation(annotation),
    );

    if (visitor.missingRequirements.isNotEmpty) {
      _throwMissingSyntaxRequirementsException(
        visitedModel,
        visitor.missingRequirements,
      );
    }

    if (visitedModel.invalidParameters().isNotEmpty) {
      _throwInvalidParameterException(visitedModel);
    }

    buffer.writeln(bypassError(visitedModel));

    buffer.writeln(MixinTemplate(visitedModel).toString());

    buffer.writeln(ConcreteTemplate(visitedModel).toString());

    buffer.writeln(AbstractTemplate(visitedModel).toString());

    if (visitedModel.options.shouldGenerateGetter) {
      if (visitedModel.requiredParameters().isNotEmpty) {
        _throwGetterWithRequiredParamsException(visitedModel);
      }
      buffer.writeln(ModifierTemplate(visitedModel).toString());
    }

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

void _throwMissingSyntaxRequirementsException(
  Model model,
  List<SyntaxRequirements> missingRequirements,
) {
  StringBuffer errorBuffer = StringBuffer();

  errorBuffer.writeln('Invalid syntax for generated model: ${model.className}');

  if (missingRequirements.contains(SyntaxRequirements.extendsRequiredClass)) {
    errorBuffer.writeln();
    errorBuffer.write('${model.className} must extend ${model.options.mustExtend}');
    errorBuffer.writeln(' if it is annotated with ${model.options.annotationName}.');
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
    element: model.annotatedElement,
  );
}

void _throwInvalidParameterException(Model model) {
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
    element: model.annotatedElement,
  );
}

void _throwGetterWithRequiredParamsException(Model model) {
  throw InvalidGenerationSourceError(
    '''
Invalid syntax for generated model: ${model.className}

You cannot use a required parameter when using ${model.options.annotationName}.
''',
    element: model.annotatedElement,
  );
}
