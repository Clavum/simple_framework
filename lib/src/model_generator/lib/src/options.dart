//ignore_for_file: avoid_positional_boolean_parameters

class Options {
  final String annotationName;
  final bool shouldGenerateMerge;
  final bool shouldGenerateModifier;
  final String? mustExtend;

  Options(
    this.annotationName,
    this.shouldGenerateMerge,
    this.shouldGenerateModifier,
      this.mustExtend,);
}
