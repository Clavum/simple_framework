import 'package:flutter_test/flutter_test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/parameter.dart';

/// -------------------------- IMPORTANT ----------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

class ElementFake extends Fake implements ClassElement {}

void main() {
  const Parameter defaultParameter = Parameter(
    name: 'default',
    defaultValue: '10',
    isRequired: false,
    type: 'int',
  );

  const Parameter customTypeParameter = Parameter(
    name: 'customType',
    defaultValue: 'Custom()',
    isRequired: false,
    type: 'Custom',
  );

  const Parameter requiredParameter = Parameter(
    name: 'requiredField',
    defaultValue: null,
    isRequired: true,
    type: 'int',
  );

  const Parameter nullableParameter = Parameter(
    name: 'nullable',
    defaultValue: null,
    isRequired: false,
    type: 'int?',
  );

  const Parameter invalidParameter = Parameter(
    name: 'invalid',
    defaultValue: null,
    isRequired: false,
    type: 'int',
  );

  const Parameter requiredNullableParameter = Parameter(
    name: 'requiredNullable',
    defaultValue: null,
    isRequired: true,
    type: 'int?',
  );

  const Parameter defaultNullableParameter = Parameter(
    name: 'defaultNullable',
    defaultValue: '10',
    isRequired: false,
    type: 'int?',
  );

  group('Model', () {
    Model testModel = Model(
      element: ElementFake(),
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

    test('Class names', () {
      expect(testModel.camelCaseName, 'className');
      expect(testModel.mixinName, '_\$ClassName');
      expect(testModel.abstractClassName, '_ClassName');
      expect(testModel.mainClassName, '_\$_ClassName');
    });

    test('invalidParameters', () {
      expect(testModel.invalidParameters(), [invalidParameter]);
    });

    test('requiredParameters', () {
      expect(testModel.requiredParameters(), [requiredParameter, requiredNullableParameter]);
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

''',
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
''',
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
''',
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
''',
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
''',
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
''',
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
''',
      );
    });
  });
}
