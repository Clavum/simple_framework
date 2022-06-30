class GenerateModel {
  final bool shouldGenerateMerge;
  final bool shouldGenerateGetter;

  const GenerateModel({
    required this.shouldGenerateMerge,
    required this.shouldGenerateGetter,
  });
}

const generateEntity = GenerateModel(
  shouldGenerateMerge: true,
  shouldGenerateGetter: true,
);

const generateViewModel = GenerateModel(
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
);

const generateServiceModel = GenerateModel(
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
