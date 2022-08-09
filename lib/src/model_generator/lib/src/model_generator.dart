import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/model_visitor.dart';
import 'package:model_generator/src/options.dart';
import 'package:model_generator/src/templates/abstract_template.dart';
import 'package:model_generator/src/templates/concrete_template.dart';
import 'package:model_generator/src/templates/mixin_template.dart';
import 'package:model_generator/src/templates/modifier_template.dart';
import 'package:model_generator/src/validator.dart';
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
      options: Options(
        annotation.read('annotationName').stringValue,
        annotation.read('shouldGenerateMerge').boolValue,
        annotation.read('shouldGenerateGetter').boolValue,
        annotation.read('shouldGenerateSetters').boolValue,
        annotation.read('mustExtend').stringValue,
      ),
    );

    Validator().assertNoMissingRequirements(visitor, visitedModel);

    Validator().assertNoInvalidParameters(visitedModel);

    buffer.writeln(bypassError(visitedModel));

    buffer.writeln(MixinTemplate(visitedModel).toString());

    buffer.writeln(ConcreteTemplate(visitedModel).toString());

    buffer.writeln(AbstractTemplate(visitedModel).toString());

    if (visitedModel.options.shouldGenerateGetter) {
      if (visitedModel.requiredParameters().isNotEmpty) {
        Validator().assertNoRequiredParameters(visitedModel);
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
