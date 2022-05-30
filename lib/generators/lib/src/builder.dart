import 'package:build/build.dart';
import 'package:generators/src/model_generator.dart';
import 'package:generators/src/view_model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      ModelGenerator(
        shouldGenerateMerge: true,
        parametersRequired: false,
        shouldGenerateGetter: true,
      )
    ],
    'entity_generator',
  );
}

Builder generateViewModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([ViewModelGenerator()], 'view_model_generator');
