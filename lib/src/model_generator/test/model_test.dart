import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/parameter.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

class ElementFake implements ClassElement {
  @override
  void noSuchMethod(Invocation invocation) {
    throw 'Unexpected invocation: ${invocation.memberName}';
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
  );

  group('Model', () {
    Model testModel = Model(
      annotatedElement: ElementFake(),
      mustExtend: 'Object',
      annotationName: 'GenerateModel',
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

    test('Class names', () {
      expect(testModel.camelCaseName, 'className');
      expect(testModel.mixinName, '_\$ClassName');
      expect(testModel.abstractClassName, '_ClassName');
      expect(testModel.mainClassName, '_\$_ClassName');
      expect(testModel.modifierClassName, '_ClassNameModifier');
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

Set<int> get set => throw Error();''',
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
Set<int>? set,''',
      );
    });

    test('concreteParameterList', () {
      expect(
        testModel.concreteParameterList(),
        '''
this.default = 10,
this.customType = Custom(),
required this.requiredField,
this.nullable,
this.invalid,
required this.requiredNullable,
this.defaultNullable = 10,
this.list = \$listDefaultValue,
required this.requiredList,
this.map = \$mapDefaultValue,
this.set = \$setDefaultValue,''',
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
final Set<int> set;''',
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
set,''',
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
set: set ?? this.set,''',
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
Set<int> set,''',
      );
    });

    test('modifierParameterList', () {
      expect(
        testModel.modifierParameterList(),
        '''
int get default => _model.default;

set default(int default) => Repository().set(_model.merge(default: default));

Custom get customType => _model.customType;

set customType(Custom customType) => Repository().set(_model.merge(customType: customType));

int get requiredField => _model.requiredField;

set requiredField(int requiredField) => Repository().set(_model.merge(requiredField: requiredField));

int? get nullable => _model.nullable;

set nullable(int? nullable) => Repository().set(_model.merge(nullable: nullable));

int get invalid => _model.invalid;

set invalid(int invalid) => Repository().set(_model.merge(invalid: invalid));

int? get requiredNullable => _model.requiredNullable;

set requiredNullable(int? requiredNullable) => Repository().set(_model.merge(requiredNullable: requiredNullable));

int? get defaultNullable => _model.defaultNullable;

set defaultNullable(int? defaultNullable) => Repository().set(_model.merge(defaultNullable: defaultNullable));

List<int> get list => _process(_model.list);

set list(List<int> list) => Repository().set(_model.merge(list: list));

List<int> get requiredList => _model.requiredList;

set requiredList(List<int> requiredList) => Repository().set(_model.merge(requiredList: requiredList));

Map<String, int> get map => _process(_model.map);

set map(Map<String, int> map) => Repository().set(_model.merge(map: map));

Set<int> get set => _process(_model.set);

set set(Set<int> set) => Repository().set(_model.merge(set: set));''',
      );
    });

    test('collectionDefaults', () {
      expect(
        testModel.collectionDefaults(),
        '''
static const List<int> \$listDefaultValue = [];
static const Map<String, int> \$mapDefaultValue = {};
static const Set<int> \$setDefaultValue = {};''',
      );
    });

    test('processParameterConversions', () {
      expect(
        testModel.processParameterConversions(),
        '''
if (object == _\$_ClassName.\$listDefaultValue) {
return (list = List.from(_\$_ClassName.\$listDefaultValue)) as E;
}
if (object == _\$_ClassName.\$mapDefaultValue) {
return (map = Map.from(_\$_ClassName.\$mapDefaultValue)) as E;
}
if (object == _\$_ClassName.\$setDefaultValue) {
return (set = Set.from(_\$_ClassName.\$setDefaultValue)) as E;
}''',
      );
    });
  });
}
