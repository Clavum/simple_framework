import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/options.dart';
import 'package:model_generator/src/parameter.dart';
import 'package:test/test.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

class ElementFake implements ClassElement {
  @override
  void noSuchMethod(Invocation invocation) {
    throw UnsupportedError('$invocation');
  }
}

void main() {
  const Parameter defaultParameter = Parameter(
    name: 'default',
    defaultValue: '10',
    isRequired: false,
    type: 'int',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter customTypeParameter = Parameter(
    name: 'customType',
    defaultValue: 'Custom()',
    isRequired: false,
    type: 'Custom',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter requiredParameter = Parameter(
    name: 'requiredField',
    defaultValue: null,
    isRequired: true,
    type: 'int',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter nullableParameter = Parameter(
    name: 'nullable',
    defaultValue: null,
    isRequired: false,
    type: 'int?',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: true,
    hasGeneratedModifier: false,
  );

  const Parameter invalidParameter = Parameter(
    name: 'invalid',
    defaultValue: null,
    isRequired: false,
    type: 'int',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter requiredNullableParameter = Parameter(
    name: 'requiredNullable',
    defaultValue: null,
    isRequired: true,
    type: 'int?',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: true,
    hasGeneratedModifier: false,
  );

  const Parameter defaultNullableParameter = Parameter(
    name: 'defaultNullable',
    defaultValue: '10',
    isRequired: false,
    type: 'int?',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: true,
    hasGeneratedModifier: false,
  );

  const Parameter listParameter = Parameter(
    name: 'list',
    defaultValue: 'const []',
    isRequired: false,
    type: 'List<int>',
    isDartCoreList: true,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter requiredList = Parameter(
    name: 'requiredList',
    defaultValue: null,
    isRequired: true,
    type: 'List<int>',
    isDartCoreList: true,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter mapParameter = Parameter(
    name: 'map',
    defaultValue: 'const {}',
    isRequired: false,
    type: 'Map<String, int>',
    isDartCoreList: false,
    isDartCoreMap: true,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter setParameter = Parameter(
    name: 'set',
    defaultValue: 'const {}',
    isRequired: false,
    type: 'Set<int>',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: true,
    isNullable: false,
    hasGeneratedModifier: false,
  );

  const Parameter nestedModelParameter = Parameter(
    name: 'nestedModel',
    defaultValue: 'ExampleModel()',
    isRequired: false,
    type: 'ExampleModel',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    hasGeneratedModifier: true,
  );

  group('Model', () {
    final Model testModel = Model(
      annotatedElement: ElementFake(),
      options: Options(
        'GenerateModel',
        true,
        true,
        'Object',
      ),
    )
      ..className = 'ClassName'
      ..parameters.addAll([
        defaultParameter,
        customTypeParameter,
        requiredParameter,
        nullableParameter,
        invalidParameter,
        requiredNullableParameter,
        defaultNullableParameter,
        listParameter,
        requiredList,
        mapParameter,
        setParameter,
        nestedModelParameter,
      ]);

    test('Class names', () {
      expect(testModel.camelCaseName, 'className');
      expect(testModel.mixinName, r'_$ClassName');
      expect(testModel.abstractClassName, '_ClassName');
      expect(testModel.mainClassName, r'_$_ClassName');
      expect(testModel.modifierClassName, r'$ClassNameModifier');
    });

    test('invalidParameters', () {
      expect(testModel.invalidParameters(), [invalidParameter]);
    });

    test('requiredParameters', () {
      expect(
        testModel.requiredParameters(),
        [requiredParameter, requiredNullableParameter, requiredList],
      );
    });

    test('getterList', () {
      expect(
        testModel.getterList(returnValue: 'throw Error()'),
        '''
int get default => throw Error();

Custom get customType => throw Error();

int get requiredField => throw Error();

int? get nullable => throw Error();

int get invalid => throw Error();

int? get requiredNullable => throw Error();

int? get defaultNullable => throw Error();

List<int> get list => throw Error();

List<int> get requiredList => throw Error();

Map<String, int> get map => throw Error();

Set<int> get set => throw Error();

ExampleModel get nestedModel => throw Error();''',
      );
    });

    test('setterList', () {
      expect(
        testModel.setterList(returnValue: 'throw Error()'),
        '''
set default(int default) => throw Error();

set customType(Custom customType) => throw Error();

set requiredField(int requiredField) => throw Error();

set nullable(int? nullable) => throw Error();

set invalid(int invalid) => throw Error();

set requiredNullable(int? requiredNullable) => throw Error();

set defaultNullable(int? defaultNullable) => throw Error();

set list(List<int> list) => throw Error();

set requiredList(List<int> requiredList) => throw Error();

set map(Map<String, int> map) => throw Error();

set set(Set<int> set) => throw Error();

set nestedModel(ExampleModel nestedModel) => throw Error();''',
      );
    });

    test('nullableParameterList', () {
      expect(
        testModel.nullableParameterList(),
        '''
int? default,
Custom? customType,
int? requiredField,
int? nullable,
int? invalid,
int? requiredNullable,
int? defaultNullable,
List<int>? list,
List<int>? requiredList,
Map<String, int>? map,
Set<int>? set,
ExampleModel? nestedModel,''',
      );
    });

    test('concreteParameterList', () {
      expect(
        testModel.concreteParameterList(),
        r'''
this.default = 10,
this.customType = Custom(),
required this.requiredField,
this.nullable,
this.invalid,
required this.requiredNullable,
this.defaultNullable = 10,
this.list = $listDefaultValue,
required this.requiredList,
this.map = $mapDefaultValue,
this.set = $setDefaultValue,
this.nestedModel = ExampleModel(),''',
      );
    });

    test('parameterOverrides', () {
      expect(
        testModel.parameterOverrides(),
        '''
@override
final int default;
@override
final Custom customType;
@override
final int requiredField;
@override
final int? nullable;
@override
final int invalid;
@override
final int? requiredNullable;
@override
final int? defaultNullable;
@override
final List<int> list;
@override
final List<int> requiredList;
@override
final Map<String, int> map;
@override
final Set<int> set;
@override
final ExampleModel nestedModel;''',
      );
    });

    test('parametersWithCommas', () {
      expect(
        testModel.parametersWithCommas(),
        '''
default,
customType,
requiredField,
nullable,
invalid,
requiredNullable,
defaultNullable,
list,
requiredList,
map,
set,
nestedModel,''',
      );
    });

    test('mergeFieldsList', () {
      expect(
        testModel.mergeFieldsList(),
        '''
default: default ?? this.default,
customType: customType ?? this.customType,
requiredField: requiredField ?? this.requiredField,
nullable: nullable ?? this.nullable,
invalid: invalid ?? this.invalid,
requiredNullable: requiredNullable ?? this.requiredNullable,
defaultNullable: defaultNullable ?? this.defaultNullable,
list: list ?? this.list,
requiredList: requiredList ?? this.requiredList,
map: map ?? this.map,
set: set ?? this.set,
nestedModel: nestedModel ?? this.nestedModel,''',
      );
    });

    test('redirectedParameterList', () {
      expect(
        testModel.redirectedParameterList(),
        '''
int default,
Custom customType,
required int requiredField,
int? nullable,
int invalid,
required int? requiredNullable,
int? defaultNullable,
List<int> list,
required List<int> requiredList,
Map<String, int> map,
Set<int> set,
ExampleModel nestedModel,''',
      );
    });

    test('modifierParameterList', () {
      expect(
        testModel.modifierParameterList(),
        r'''
@override
int get default => _get.default;

@override
set default(int default) => _set(_get.merge(default: default));

@override
Custom get customType => _get.customType;

@override
set customType(Custom customType) => _set(_get.merge(customType: customType));

@override
int get requiredField => _get.requiredField;

@override
set requiredField(int requiredField) => _set(_get.merge(requiredField: requiredField));

@override
int? get nullable => _get.nullable;

@override
set nullable(int? nullable) => _set(_get.merge(nullable: nullable));

@override
int get invalid => _get.invalid;

@override
set invalid(int invalid) => _set(_get.merge(invalid: invalid));

@override
int? get requiredNullable => _get.requiredNullable;

@override
set requiredNullable(int? requiredNullable) => _set(_get.merge(requiredNullable: requiredNullable));

@override
int? get defaultNullable => _get.defaultNullable;

@override
set defaultNullable(int? defaultNullable) => _set(_get.merge(defaultNullable: defaultNullable));

@override
List<int> get list {
  final value = _get.list;
  return (value == _$_ClassName.$listDefaultValue) ? list = List.from(value) : value;
}

@override
set list(List<int> list) => _set(_get.merge(list: list));

@override
List<int> get requiredList => _get.requiredList;

@override
set requiredList(List<int> requiredList) => _set(_get.merge(requiredList: requiredList));

@override
Map<String, int> get map {
  final value = _get.map;
  return (value == _$_ClassName.$mapDefaultValue) ? map = Map.from(value) : value;
}

@override
set map(Map<String, int> map) => _set(_get.merge(map: map));

@override
Set<int> get set {
  final value = _get.set;
  return (value == _$_ClassName.$setDefaultValue) ? set = Set.from(value) : value;
}

@override
set set(Set<int> set) => _set(_get.merge(set: set));

@override
$ExampleModelModifier get nestedModel => $ExampleModelModifier(
        () => _get.nestedModel,
        (ExampleModel nestedModel) => this.nestedModel = nestedModel,
        (silent) => send(silent: silent),
      );

@override
set nestedModel(ExampleModel nestedModel) => _set(_get.merge(nestedModel: nestedModel));''',
      );
    });

    test('collectionDefaults', () {
      expect(
        testModel.collectionDefaults(),
        r'''
static const List<int> $listDefaultValue = [];
static const Map<String, int> $mapDefaultValue = {};
static const Set<int> $setDefaultValue = {};''',
      );
    });
  });
}
