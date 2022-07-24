import 'package:build/build.dart';
import 'package:model_generator/src/model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateModelBuilder(BuilderOptions options) {
  return PartBuilder(
    [ModelGenerator()],
    '.model.dart',
    header: '''
// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file
''',
  );
}
