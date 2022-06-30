class GenerateModel {
  final bool shouldGenerateMerge;
  final bool parametersRequired;
  final bool shouldGenerateGetter;

  const GenerateModel({
    required this.shouldGenerateMerge,
    required this.parametersRequired,
    required this.shouldGenerateGetter,
  });
}

const generateEntity = GenerateModel(
  shouldGenerateMerge: true,
  parametersRequired: false,
  shouldGenerateGetter: true,
);

const generateViewModel = GenerateModel(
  shouldGenerateMerge: false,
  parametersRequired: true,
  shouldGenerateGetter: false,
);

const generateServiceModel = GenerateModel(
  shouldGenerateMerge: false,
  parametersRequired: false,
  shouldGenerateGetter: false,
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
