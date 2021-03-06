class Parameter {
  final String? defaultValue;
  final String type;
  final String name;
  final bool isRequired;

  const Parameter({
    required this.defaultValue,
    required this.type,
    required this.name,
    required this.isRequired,
  });

  bool get isNullable {
    return type.substring(type.length - 1) == '?';
  }

  /// Format as a getter method which returns [returnValue].
  /// ```dart
  /// ExampleType get exampleName => [returnValue];
  /// ```
  String getter([String? returnValue]) {
    if (returnValue != null) {
      return '$type get $name => $returnValue;';
    } else {
      return '$type get $name;';
    }
  }

  /// Format as a nullable parameter:
  /// ```dart
  /// ExampleType? exampleName,
  /// ```
  String nullableParameter() {
    String addNullable = isNullable ? '' : '?';
    return '$type$addNullable $name,';
  }

  /// Format as a parameter with nothing else added.
  /// ```dart
  /// ExampleType exampleName,
  /// ```
  String simpleParameter() {
    return '$type $name,';
  }

  /// Format as a required parameter:
  /// ```dart
  /// required this.exampleName,
  /// ```
  String requiredParameter() {
    return 'required this.$name,';
  }

  /// Format as a parameter which defaults to the default value:
  /// ```dart
  /// this.exampleName = defaultValue,
  /// ```
  String defaultedParameter() {
    if (defaultValue == null) {
      return 'this.$name,';
    } else {
      return 'this.$name = $defaultValue,';
    }
  }

  /// Format as a final local variable:
  /// ```dart
  /// final ExampleType exampleName;
  /// ```
  String finalVariable() {
    return 'final $type $name;';
  }

  /// Merges an optional value into a local field with the same name.
  /// ```dart
  /// exampleName: exampleName ?? this.exampleName,
  /// ```
  String mergeField() {
    return '$name: $name ?? this.$name,';
  }
}
