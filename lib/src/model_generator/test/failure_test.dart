@Tags(['failure'])
import 'package:model_generator/src/model_generator.dart';
import 'package:model_generator_annotation/model_generator_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

/// -------------------------- IMPORTANT ----------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory('test/sources', 'failure.dart');

  initializeBuildLogTracking();

  testAnnotatedElements<GenerateModel>(
    reader,
    ModelGenerator(),
  );
}
