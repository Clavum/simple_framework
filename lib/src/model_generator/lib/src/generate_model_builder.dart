import 'package:build/build.dart';
import 'package:model_generator/src/model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateModelBuilder(BuilderOptions options) {
  return PartBuilder(
    [ModelGenerator()],
    '.model.dart',
    header: '''
// ignore_for_file: prefer_const_constructors, unused_element, sort_constructors_first, library_private_types_in_public_api
// coverage:ignore-file
''',
  );
}
