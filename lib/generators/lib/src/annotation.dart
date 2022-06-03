class GenerateModel {
  final bool shouldGenerateMerge;
  final bool parametersRequired;
  final bool shouldGenerateGetter;
  final bool allowCustomMethods;
  final String modelName;

  const GenerateModel({
    required this.shouldGenerateMerge,
    required this.parametersRequired,
    required this.shouldGenerateGetter,
    required this.allowCustomMethods,
    this.modelName = 'Model',
  });
}

const generateEntity = GenerateModel(
  shouldGenerateMerge: true,
  parametersRequired: false,
  shouldGenerateGetter: true,
  allowCustomMethods: true,
  modelName: 'Entity',
);

const generateViewModel = GenerateModel(
  shouldGenerateMerge: false,
  parametersRequired: true,
  shouldGenerateGetter: false,
  allowCustomMethods: false,
  modelName: 'ViewModel',
);

const generateServiceModel = GenerateModel(
  shouldGenerateMerge: false,
  parametersRequired: true,
  shouldGenerateGetter: false,
  allowCustomMethods: true,
  modelName: 'ServiceModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
