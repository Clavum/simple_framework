import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/parameter.dart';

class Model {
  final Element element;
  final String annotationName;
  final String? mustExtend;

  String className = '';

  List<Parameter> parameters = [];

  Model({
    required this.element,
    required this.annotationName,
    required this.mustExtend,
  });

  String get camelCaseName {
    String firstLetter = className.substring(0, 1);
    return '${firstLetter.toLowerCase()}${className.substring(1, className.length)}';
  }

  String get abstractClassName => '_$className';

  String get mixinName => '_\$$className';

  String get mainClassName => '_\$_$className';

  String get modifierClassName => '_${className}Modifier';

  String get bypassError => '_${camelCaseName}BypassError';

  bool get hasDartCoreCollection => parameters.any((Parameter parameter) {
        return parameter.isDartCoreList || parameter.isDartCoreSet || parameter.isDartCoreMap;
      });

  List<Parameter> invalidParameters() {
    List<Parameter> invalidParameters = [];
    for (var parameter in parameters) {
      if (!parameter.isRequired && !parameter.isNullable && parameter.defaultValue == null) {
        invalidParameters.add(parameter);
      }
    }
    return invalidParameters;
  }

  List<Parameter> requiredParameters() {
    List<Parameter> requiredParameters = [];
    for (var parameter in parameters) {
      if (parameter.isRequired) {
        requiredParameters.add(parameter);
      }
    }
    return requiredParameters;
  }

  /// List value of [Parameter.getter] with spaces between.
  String getterList({String? returnValue, bool useOverride = false}) {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      if (useOverride) {
        buffer.writeln('@override');
      }
      buffer
        ..writeln(parameter.getter(returnValue))
        ..writeln();
    }
    return buffer.toString();
  }

  /// List value of [Parameter.nullableParameter].
  String nullableParameterList() {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      buffer.writeln(parameter.nullableParameter());
    }
    return buffer.toString();
  }

  /// For each parameter, lists [Parameter.requiredParameter] if it is required
  /// or [Parameter.defaultedParameter] otherwise.
  String concreteParameterList() {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      if (parameter.isRequired) {
        buffer.writeln(parameter.requiredParameter());
      } else {
        buffer.writeln(parameter.defaultedParameter());
      }
    }
    return buffer.toString();
  }

  /// Lists every parameter as an instance field annotated with @override.
  String parameterOverrides() {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      buffer
        ..writeln('@override')
        ..writeln(parameter.finalVariable());
    }
    return buffer.toString();
  }

  /// Lists every parameter name with a comma after it.
  String parametersWithCommas() {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      buffer.writeln('${parameter.name},');
    }
    return buffer.toString();
  }

  /// Lists every parameter like the following, which is used for merging.
  /// `someField: someField ?? this.someField`
  String mergeFieldsList() {
    final StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      buffer.writeln(parameter.mergeField());
    }
    return buffer.toString();
  }

  /// Lists every parameter in a format such that they can be redirected to
  /// another constructor, i.e. default value is not used.
  String redirectedParameterList() {
    StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      String required = (parameter.isRequired) ? 'required ' : '';
      buffer.writeln('$required${parameter.simpleParameter()}');
    }
    return buffer.toString();
  }

  /// Lists parameters with getters and setters that depend on the Repository.
  String modifierParameterList() {
    StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      buffer
        ..writeln(parameter.modifierGetter())
        ..writeln()
        ..writeln(parameter.modifierSetter())
        ..writeln();
    }
    return buffer.toString();
  }

  String collectionDefaults() {
    StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      if (parameter.isEligibleForModifier) {
        buffer.writeln(parameter.collectionDefault());
      }
    }
    return buffer.toString();
  }

  /// Makes any necessary conversions when the modifier getter is called.
  String processParameterConversions() {
    StringBuffer buffer = StringBuffer();
    for (var parameter in parameters) {
      if (parameter.isEligibleForModifier) {
        String collectionName = parameter.isDartCoreList
            ? 'List'
            : parameter.isDartCoreSet
                ? 'Set'
                : 'Map';
        buffer
          ..writeln('if (object == ${mainClassName}.${parameter.defaultValueName}) {')
          ..write('return (${parameter.name} = ')
          ..writeln('$collectionName.from(${mainClassName}.${parameter.defaultValueName})) as E;')
          ..writeln('}');
      }
    }
    return buffer.toString();
  }
}
