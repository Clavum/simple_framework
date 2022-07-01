class GenerateModel {
  final String annotationName;
  final bool shouldGenerateMerge;
  final bool shouldGenerateGetter;
  final String? mustExtend;

  const GenerateModel({
    this.annotationName = '@GenerateModel',
    required this.shouldGenerateMerge,
    required this.shouldGenerateGetter,
    this.mustExtend,
  });
}

const generateEntity = GenerateModel(
  annotationName: '@generateEntity',
  shouldGenerateMerge: true,
  shouldGenerateGetter: true,
  mustExtend: 'Entity',
);

const generateViewModel = GenerateModel(
  annotationName: '@generateViewModel',
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
  mustExtend: 'ViewModel',
);

const generateServiceModel = GenerateModel(
  annotationName: '@generateServiceModel',
  shouldGenerateMerge: false,
  shouldGenerateGetter: false,
  mustExtend: 'ServiceModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
