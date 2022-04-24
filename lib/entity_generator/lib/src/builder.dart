import 'package:build/build.dart';
import 'package:entity_generator/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateEntityBuilder(BuilderOptions options) =>
    SharedPartBuilder([EntityGenerator()], 'entity_generator');