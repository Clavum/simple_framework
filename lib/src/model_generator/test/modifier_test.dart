import 'dart:async';

import 'package:simple_framework/simple_framework.dart';
import 'package:test/test.dart';

import 'sources/modifier.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
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
    // Can send the model.
    late StreamSubscription subscription;
    subscription = Repository().streamOf<ModifierEntity>().listen(
      expectAsync1((entity) {
        expect(entity.intValue, 10);
        subscription.cancel();
      }),
    );
    modifierEntity.send();
  });

  test('can set the entire model', () {
    modifierEntity.intValue = 987;
    modifierEntity.set(const ModifierEntity(intValue: 10));
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
}
