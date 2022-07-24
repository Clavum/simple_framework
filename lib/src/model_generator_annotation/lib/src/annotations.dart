class GenerateModel {
  /// The name of the annotation used.
  final String annotationName;

  /// Whether to generate the merge method.
  final bool shouldGenerateMerge;

  /// Whether to add List<EntityFailure> as a parameter.
  final bool addErrorsParameter;

  /// The name of a class which the annotated class must extend.
  final String? mustExtend;

  const GenerateModel({
    this.annotationName = '@GenerateModel',
    required this.shouldGenerateMerge,
    required this.addErrorsParameter,
    this.mustExtend,
  });
}

const generateEntity = GenerateModel(
  annotationName: '@generateEntity',
  shouldGenerateMerge: true,
  addErrorsParameter: true,
  mustExtend: 'Entity',
);

const generateViewModel = GenerateModel(
  annotationName: '@generateViewModel',
  shouldGenerateMerge: false,
  addErrorsParameter: false,
  mustExtend: 'ViewModel',
);

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}
