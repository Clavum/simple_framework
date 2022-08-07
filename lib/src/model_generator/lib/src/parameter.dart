class Parameter {
  final String? defaultValue;
  final String type;
  final String name;
  final bool isRequired;
  final bool isDartCoreList;
  final bool isDartCoreMap;
  final bool isDartCoreSet;
  final bool isNullable;

  const Parameter({
    required this.defaultValue,
    required this.type,
    required this.name,
    required this.isRequired,
    required this.isDartCoreList,
    required this.isDartCoreMap,
    required this.isDartCoreSet,
    required this.isNullable,
  });

  bool get isValid => isRequired || isNullable || defaultValue != null;

  bool get isEligibleForModifier {
    return (isDartCoreList || isDartCoreMap || isDartCoreSet) && !isRequired;
  }

  String get defaultValueName => '\$${name}DefaultValue';

  String get collectionName {
    if (isDartCoreList) {
      return 'List';
    } else if (isDartCoreSet) {
      return 'Set';
    } else if (isDartCoreMap) {
      return 'Map';
    } else {
      throw FallThroughError();
    }
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

  /// Format as a setter method which calls [returnValue].
  /// ```dart
  /// set exampleName(ExampleType exampleName) => [returnValue];
  /// ```
  String setter([String? returnValue]) {
    if (returnValue != null) {
      return 'set $name($type $name) => $returnValue;';
    } else {
      return 'set $name($type $name);';
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
    } else if (isEligibleForModifier) {
      return 'this.$name = $defaultValueName,';
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

  /// Format as a getter which returns the current value from the [Repository].
  String modifierGetter() {
    if (isEligibleForModifier) {
      return '${getter('_process(_get.$name)')}';
    } else {
      return '${getter('_get.$name')}';
    }
  }

  /// Format as a setter which updates the value in the [Repository].
  String modifierSetter() {
    return '${setter('_set(_get.merge($name: $name))')}';
  }

  String collectionDefault() {
    return 'static const $type $defaultValueName = $defaultValue;';
  }
}
