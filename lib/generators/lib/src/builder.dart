import 'package:build/build.dart';
import 'package:generators/src/model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateModelBuilder(BuilderOptions options) {
  // The partId should match the build extension from build.yaml
  return PartBuilder([ModelGenerator()], '.g.dart');
}
