class GenerateModel {
  /// The name of the annotation used.
  final String annotationName;

  /// Whether to generate the merge method.
  final bool shouldGenerateMerge;

  /// Whether to generate a global Entity getter
  final bool shouldGenerateGetter;

  /// Whether to generate setter methods which update the Model in the Repository.
  final bool shouldGenerateSetters;

  /// The name of the class which the annotated Model must extend.
  final String? mustExtend;

  const GenerateModel({
    this.annotationName = '@GenerateModel',
    required this.shouldGenerateMerge,
    required this.shouldGenerateGetter,
    required this.shouldGenerateSetters,
    this.mustExtend,
  });
}

const generateEntity = GenerateModel(
  annotationName: '@generateEntity',
  shouldGenerateMerge: true,
  shouldGenerateGetter: true,
  shouldGenerateSetters: true,
  mustExtend: 'Entity',
);

const generateViewModel = GenerateModel(
  annotationName: '@generateViewModel',
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
  shouldGenerateSetters: false,
  mustExtend: 'ViewModel',
);

const generateServiceModel = GenerateModel(
  annotationName: '@generateServiceModel',
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
  shouldGenerateSetters: false,
  mustExtend: 'ServiceModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
