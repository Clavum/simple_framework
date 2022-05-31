export 'package:collection/collection.dart' show DeepCollectionEquality;

class GenerateModel {
  final bool shouldGenerateMerge;
  final bool parametersRequired;
  final bool shouldGenerateGetter;
  final String modelName;

  const GenerateModel({
    required this.shouldGenerateMerge,
    required this.parametersRequired,
    required this.shouldGenerateGetter,
    this.modelName = 'Model',
  });
}

const generateEntity = GenerateModel(
  shouldGenerateMerge: true,
  parametersRequired: false,
  shouldGenerateGetter: true,
  modelName: 'Entity',
);

const generateViewModel = GenerateModel(
  shouldGenerateMerge: false,
  parametersRequired: true,
  shouldGenerateGetter: false,
  modelName: 'ViewModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
