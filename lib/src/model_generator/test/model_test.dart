import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/parameter.dart';
import 'package:model_generator/src/options.dart';

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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
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
    isGeneratedModel: false,
  );

  const Parameter listParameter = Parameter(
    name: 'list',
    defaultValue: '[]',
    isRequired: false,
    type: 'List<int>',
    isDartCoreList: true,
    isDartCoreMap: false,
    isDartCoreSet: false,
    isNullable: false,
    isGeneratedModel: false,
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
    isGeneratedModel: false,
  );

  const Parameter mapParameter = Parameter(
    name: 'map',
    defaultValue: '{}',
    isRequired: false,
    type: 'Map<String, int>',
    isDartCoreList: false,
    isDartCoreMap: true,
    isDartCoreSet: false,
    isNullable: false,
    isGeneratedModel: false,
  );

  const Parameter setParameter = Parameter(
    name: 'set',
    defaultValue: '{}',
    isRequired: false,
    type: 'Set<int>',
    isDartCoreList: false,
    isDartCoreMap: false,
    isDartCoreSet: true,
    isNullable: false,
    isGeneratedModel: false,
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
    isGeneratedModel: true,
  );

  group('Model', () {
    Model testModel = Model(
      annotatedElement: ElementFake(),
      options: Options(
        'GenerateModel',
        true,
        true,
        true,
        'Object',
      ),
    );
    testModel.className = 'ClassName';
    testModel.parameters.add(defaultParameter);
    testModel.parameters.add(customTypeParameter);
    testModel.parameters.add(requiredParameter);
    testModel.parameters.add(nullableParameter);
    testModel.parameters.add(invalidParameter);
    testModel.parameters.add(requiredNullableParameter);
    testModel.parameters.add(defaultNullableParameter);
    testModel.parameters.add(listParameter);
    testModel.parameters.add(requiredList);
    testModel.parameters.add(mapParameter);
    testModel.parameters.add(setParameter);
    testModel.parameters.add(nestedModelParameter);

    test('Class names', () {
      expect(testModel.camelCaseName, 'className');
      expect(testModel.mixinName, '_\$ClassName');
      expect(testModel.abstractClassName, '_ClassName');
      expect(testModel.mainClassName, '_\$_ClassName');
      expect(testModel.modifierClassName, '\$ClassNameModifier');
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
int get default => _get.default;

set default(int default) => _set(_get.merge(default: default));

Custom get customType => _get.customType;

set customType(Custom customType) => _set(_get.merge(customType: customType));

int get requiredField => _get.requiredField;

set requiredField(int requiredField) => _set(_get.merge(requiredField: requiredField));

int? get nullable => _get.nullable;

set nullable(int? nullable) => _set(_get.merge(nullable: nullable));

int get invalid => _get.invalid;

set invalid(int invalid) => _set(_get.merge(invalid: invalid));

int? get requiredNullable => _get.requiredNullable;

set requiredNullable(int? requiredNullable) => _set(_get.merge(requiredNullable: requiredNullable));

int? get defaultNullable => _get.defaultNullable;

set defaultNullable(int? defaultNullable) => _set(_get.merge(defaultNullable: defaultNullable));

List<int> get list => _process(_get.list);

set list(List<int> list) => _set(_get.merge(list: list));

List<int> get requiredList => _get.requiredList;

set requiredList(List<int> requiredList) => _set(_get.merge(requiredList: requiredList));

Map<String, int> get map => _process(_get.map);

set map(Map<String, int> map) => _set(_get.merge(map: map));

Set<int> get set => _process(_get.set);

set set(Set<int> set) => _set(_get.merge(set: set));

$ExampleModelModifier get nestedModel => $ExampleModelModifier(
        () => _get.nestedModel,
        (ExampleModel nestedModel) => this.nestedModel = nestedModel,
        () => send(),
      );

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

    test('processParameterConversions', () {
      expect(
        testModel.processParameterConversions(),
        r'''
if (object == _$_ClassName.$listDefaultValue) {
return (list = List.from(_$_ClassName.$listDefaultValue)) as E;
}
if (object == _$_ClassName.$mapDefaultValue) {
return (map = Map.from(_$_ClassName.$mapDefaultValue)) as E;
}
if (object == _$_ClassName.$setDefaultValue) {
return (set = Set.from(_$_ClassName.$setDefaultValue)) as E;
}''',
      );
    });
  });
}
