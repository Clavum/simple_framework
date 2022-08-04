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
}
