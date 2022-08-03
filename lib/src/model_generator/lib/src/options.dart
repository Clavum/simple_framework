import 'package:source_gen/source_gen.dart';

class Options {
  final String annotationName;
  final bool shouldGenerateMerge;
  final bool shouldGenerateGetter;
  final bool shouldGenerateSetters;
  final String? mustExtend;

  Options(
    this.annotationName,
    this.shouldGenerateMerge,
    this.shouldGenerateGetter,
    this.shouldGenerateSetters,
    this.mustExtend,
  );

  factory Options.fromAnnotation(
    ConstantReader annotation,
  ) {
    return Options(
      annotation.read('annotationName').stringValue,
      annotation.read('shouldGenerateMerge').boolValue,
      annotation.read('shouldGenerateGetter').boolValue,
      annotation.read('shouldGenerateSetters').boolValue,
      annotation.read('mustExtend').stringValue,
    );
  }
}
