class GenerateModel {
  /// The name of the annotation used.
  final String annotationName;

  /// Whether to generate the merge method.
  final bool shouldGenerateMerge;

  /// Whether to generate a modifier class.
  final bool shouldGenerateModifier;

  /// The name of the class which the annotated Model must extend.
  final String? mustExtend;

  const GenerateModel({
    this.annotationName = '@GenerateModel',
    required this.shouldGenerateMerge,
    required this.shouldGenerateModifier,
    this.mustExtend,
  });
}

const generateModel = GenerateModel(
  annotationName: '@generateModel',
  shouldGenerateMerge: true,
  shouldGenerateModifier: false,
  mustExtend: 'Model',
);

const generateEntity = GenerateModel(
  annotationName: '@generateEntity',
  shouldGenerateMerge: true,
  shouldGenerateModifier: true,
  mustExtend: 'Entity',
);

const generateViewModel = GenerateModel(
  annotationName: '@generateViewModel',
  shouldGenerateMerge: false,
  shouldGenerateModifier: false,
  mustExtend: 'ViewModel',
);

const generateServiceModel = GenerateModel(
  annotationName: '@generateServiceModel',
  shouldGenerateMerge: false,
  shouldGenerateModifier: false,
  mustExtend: 'ServiceModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
