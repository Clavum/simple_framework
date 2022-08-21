import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/options.dart';
import 'package:model_generator/src/parameter.dart';

class Model {
  final Element annotatedElement;
  final Options options;

  String className = '';

  List<Parameter> parameters = [];

  Model({
    required this.annotatedElement,
    required this.options,
  });

  String get camelCaseName {
    String firstLetter = className.substring(0, 1);
    return '${firstLetter.toLowerCase()}${className.substring(1, className.length)}';
  }

  String get abstractClassName => '_$className';

  String get mixinName => '_\$$className';

  String get mainClassName => '_\$_$className';

  String get modifierClassName => '\$${className}Modifier';

  String get bypassError => '_${camelCaseName}BypassError';

  bool get hasDartCoreCollection => parameters.any((Parameter parameter) {
        return parameter.isDartCoreList || parameter.isDartCoreSet || parameter.isDartCoreMap;
      });

  List<Parameter> invalidParameters() {
    return parameters.where((parameter) => !parameter.isValid).toList();
  }

  List<Parameter> requiredParameters() {
    return parameters.where((parameter) => parameter.isRequired).toList();
  }

  /// --- Example format ---
  /// @override
  /// String get fieldName => [returnValue];
  String getterList({String? returnValue, bool useOverride = false}) {
    return parameters
        .expand((parameter) => [if (useOverride) '@override', parameter.getter(returnValue)])
        .join('\n\n');
  }

  /// --- Example format ---
  /// String? fieldName,
  String nullableParameterList() {
    return parameters.map((parameter) => parameter.nullableParameter()).join('\n');
  }

  /// --- Example format ---
  /// required this.fieldName,            <-- for required parameters
  /// this.fieldName = [defaultValue],    <-- for default parameters
  String concreteParameterList() {
    return parameters.map((parameter) {
      return parameter.isRequired ? parameter.requiredParameter() : parameter.defaultedParameter();
    }).join('\n');
  }

  /// --- Example format ---
  /// @override
  /// final String fieldName;
  String parameterOverrides() {
    return parameters.expand((parameter) => ['@override', parameter.finalVariable()]).join('\n');
  }

  /// --- Example format ---
  /// fieldName,
  String parametersWithCommas() {
    return parameters.map((parameter) => '${parameter.name},').join('\n');
  }

  /// Used for the merge method's body.
  /// --- Example format ---
  /// fieldName: fieldName ?? this.fieldName,
  String mergeFieldsList() {
    return parameters.map((parameter) => parameter.mergeField()).join('\n');
  }

  /// Lists every parameter in a format such that they can be redirected to
  /// another constructor, i.e. default value is not used.
  /// --- Example format ---
  /// required String fieldName,     <-- for required parameters
  /// String fieldName,              <-- for default parameters
  String redirectedParameterList() {
    return parameters.map((parameter) {
      return '${(parameter.isRequired) ? 'required ' : ''}${parameter.simpleParameter()}';
    }).join('\n');
  }

  /// Used by the modifier class to get and set fields using the [Repository].
  /// --- Example format ---
  /// String get fieldName => _model.fieldName;
  ///
  /// set fieldName(String fieldName) => Repository().set(_model.merge(fieldName: fieldName));
  String modifierParameterList() {
    return parameters.expand((parameter) {
      return [parameter.modifierGetter(mainClassName), parameter.modifierSetter()];
    }).join('\n\n');
  }

  String modifierGetter(Parameter parameter) {
    return '''
$className get ${parameter.name} => $modifierClassName(
  () => _get.${parameter.name},
  (${className} ) => this.basicEntity = basicEntity,
  () => send(),
);
    ''';
  }

  /// --- Example format ---
  /// static const List<int> $fieldNameDefaultValue = [defaultValue];
  String collectionDefaults() {
    return parameters.expand((parameter) {
      return parameter.isOptionalIterable ? [parameter.collectionDefault()] : [];
    }).join('\n');
  }

  /// Used for the merge method of the modifier class.
  /// --- Example format ---
  /// if (fieldName != null) {
  /// this.fieldName = fieldName;
  /// }
  String modifierMergeSetters() {
    return parameters.expand((parameter) {
      return [
        'if (${parameter.name} != null) {',
        'this.${parameter.name} = ${parameter.name};',
        '}',
      ];
    }).join('\n');
  }
}
