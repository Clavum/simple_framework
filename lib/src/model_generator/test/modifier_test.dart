import 'dart:async';

import 'package:simple_framework/simple_framework.dart';
import 'package:test/test.dart';

import 'sources/basic.dart';
import 'sources/modifier.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  setUp(() {
    Repository().reset();
  });

  test('fetches latest values', () {
    expect(modifierEntity.intValue, 0);
    Repository().set(const ModifierEntity(intValue: 10));
    expect(modifierEntity.intValue, 10);
  });

  test('can set values', () {
    modifierEntity.intValue = 10;
    expect(modifierEntity.intValue, 10);
  });

  test('can send to Repository', () {
    late StreamSubscription subscription;
    subscription = Repository().streamOf<ModifierEntity>().listen(
      expectAsync1((entity) {
        expect(entity.intValue, 10);
        subscription.cancel();
      }),
    );
    modifierEntity.intValue = 10;
    modifierEntity.send();
  });

  test('can set the entire model', () {
    modifierEntity.intValue = 987;
    modifierEntity = const ModifierEntity(intValue: 10);
    expect(modifierEntity.intValue, 10);
  });

  test('can modify lists', () {
    modifierEntity.listValue = [1, 2, 3];
    expect(modifierEntity.listValue, [1, 2, 3]);

    modifierEntity.listValue.add(4);
    expect(modifierEntity.listValue, [1, 2, 3, 4]);

    modifierEntity.listValue.clear();
    expect(modifierEntity.listValue, []);

    Repository().removeModel<ModifierEntity>();
    modifierEntity.listValue.addAll([1, 2, 3]);
    expect(modifierEntity.listValue, [1, 2, 3]);
  });

  test('can modify maps', () {
    modifierEntity.mapValue = {'a': 1, 'b': 2, 'c': 3};
    expect(modifierEntity.mapValue, {'a': 1, 'b': 2, 'c': 3});

    modifierEntity.mapValue['d'] = 4;
    expect(modifierEntity.mapValue, {'a': 1, 'b': 2, 'c': 3, 'd': 4});

    modifierEntity.mapValue.clear();
    expect(modifierEntity.mapValue, {});

    Repository().removeModel<ModifierEntity>();
    modifierEntity.mapValue['a'] = 1;
    expect(modifierEntity.mapValue, {'a': 1});
    expect(modifierEntity.mapValue['a'], 1);
  });

  test('can modify sets', () {
    modifierEntity.setValue = {1, 2, 3};
    expect(modifierEntity.setValue, {1, 2, 3});

    modifierEntity.setValue.add(4);
    expect(modifierEntity.setValue, {1, 2, 3, 4});

    modifierEntity.setValue.clear();
    expect(modifierEntity.setValue, Set.from({}));

    Repository().removeModel<ModifierEntity>();
    modifierEntity.setValue.addAll({1, 2, 3});
    expect(modifierEntity.setValue, {1, 2, 3});
  });

  test('works with null by default collections', () {
    expect(modifierEntity.defaultNullList, null);
    modifierEntity.defaultNullList = [1, 2, 3];
    expect(modifierEntity.defaultNullList, [1, 2, 3]);
    expect(modifierEntity.defaultNullMap, null);
    modifierEntity.defaultNullMap = {'a': 1};
    expect(modifierEntity.defaultNullMap, {'a': 1});
    expect(modifierEntity.defaultNullSet, null);
    modifierEntity.defaultNullSet = {1, 2, 3};
    expect(modifierEntity.defaultNullSet, {1, 2, 3});
  });

  test('can modify nested models', () {
    modifierEntity.basicEntity.value = 10;
    expect(modifierEntity.basicEntity.value, 10);

    // Setting a nested value should NOT influence the global value.
    expect(basicEntity.value, 0);
  });

  test('sending a nested model sends the root model', () {
    late StreamSubscription subscription;
    subscription = Repository().streamOf<ModifierEntity>().listen(
      expectAsync1((entity) {
        expect(entity.basicEntity.value, 10);
        subscription.cancel();
      }),
    );
    modifierEntity.basicEntity.value = 10;
    modifierEntity.basicEntity.send();
  });

  test('can compare modifier with a model', () {
    modifierEntity.intValue = 10;
    expect(modifierEntity, const ModifierEntity(intValue: 10));
  });

  test('can use merge to set multiple values at once', () {
    modifierEntity.merge(intValue: 10, listValue: [1, 2, 3]);
    expect(modifierEntity.intValue, 10);
    expect(modifierEntity.listValue, [1, 2, 3]);
  });

  test("regression - iterable fields with same default value don't reset each other", () {
    modifierEntity.mapValue = {'a': 1};
    expect(modifierEntity.mapValue, {'a': 1});
    // Retrieving the value of another field with the same object type and default value used to
    // reset the first field.
    modifierEntity.secondMap;
    expect(modifierEntity.mapValue, {'a': 1});
  });

  test('regression - setters are part of model interface', () {
    void expectsModel(ModifierEntity entity) {
      // Given a model, we can call setters on it.
      entity.intValue = 10;
    }

    expectsModel(modifierEntity);
    expect(modifierEntity.intValue, 10);
  });
}
