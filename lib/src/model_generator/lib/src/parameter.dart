class Parameter {
  final String? defaultValue;
  final String type;
  final String name;
  final bool isRequired;
  final bool isDartCoreList;
  final bool isDartCoreMap;
  final bool isDartCoreSet;
  final bool isNullable;
  final bool hasGeneratedModifier;

  const Parameter({
    required this.defaultValue,
    required this.type,
    required this.name,
    required this.isRequired,
    required this.isDartCoreList,
    required this.isDartCoreMap,
    required this.isDartCoreSet,
    required this.isNullable,
    required this.hasGeneratedModifier,
  });

  bool get isValid => isRequired || isNullable || defaultValue != null;

  bool get isOptionalIterable {
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
      throw StateError('Parameter is not a collection type.');
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
    final String addNullable = isNullable ? '' : '?';
    return '$type$addNullable $name,';
  }

  /// Format as a parameter with a sentinel value:
  /// ```dart
  /// Object? exampleName = _$ClassName._sentinel,
  /// ```
  String asSentinelParameter(String mixinName) {
    return 'Object? $name = $mixinName._sentinel,';
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
    } else if (isOptionalIterable) {
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
  /// fieldName: fieldName == _$ClassName._sentinel ? this.fieldName : fieldName as String,
  /// ```
  String mergeField(String mixinClassName) {
    return '$name: $name == $mixinClassName._sentinel ? this.$name : $name as $type,';
  }

  /// Format as a getter which returns the current value from the Repository.
  String modifierGetter(String mainClassName) {
    if (isOptionalIterable) {
      return '''
@override
$type get $name {
  final value = _get.$name;
  return (value == $mainClassName.$defaultValueName && value != null) ? $name = $collectionName.from(value) : value;
}''';
    } else if (hasGeneratedModifier) {
      return '''
@override
\$${type}Modifier get $name => \$${type}Modifier(
        () => _get.$name,
        ($type $name) => this.$name = $name,
        (silent) => send(silent: silent),
      );''';
    } else {
      return '@override\n${getter('_get.$name')}';
    }
  }

  /// Format as a setter which updates the value in the Repository.
  String modifierSetter() {
    return '@override\n${setter('_set(_get.merge($name: $name))')}';
  }

  String collectionDefault() {
    final withoutConst =
        (defaultValue?.substring(0, 6) == 'const ') ? defaultValue!.substring(6) : defaultValue;
    return 'static const $type $defaultValueName = $withoutConst;';
  }
}
