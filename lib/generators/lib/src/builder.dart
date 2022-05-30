import 'package:build/build.dart';
import 'package:generators/src/model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateModelBuilder(BuilderOptions options) {
  return SharedPartBuilder([ModelGenerator()], 'model_generator');
}
