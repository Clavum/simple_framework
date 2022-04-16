//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final E defaultEntity;

  final List<StreamSubscription<void>> _entitySubscriptions = [];

  final Map<Type, Function> _entityCombiners = {};

  Bloc(this.defaultEntity);

  E get entity => Repository().get(defaultEntity);

  void synchronizeWithRepo<T extends Entity>(T initialEntity, Entity Function(T) entityCombiner) {
    _entityCombiners[T] = entityCombiner;
    Repository().set<E>(entityCombiner(Repository().get(initialEntity)) as E);
    _entitySubscriptions.add(
      Repository().streamOf<T>().listen((balanceEntity) {
        entityCombiner(Repository().get(balanceEntity)).send();
      }),
    );
  }

  void onCreate() {}

  @mustCallSuper
  void dispose() {
    for (var subscription in _entitySubscriptions) {
      subscription.cancel();
    }
  }

  /// Is used by, and has little use outside of, the framework. It is used to automatically set up
  /// the mock entity inside of bloc test groups using the default entity.
  @visibleForTesting
  void addEntityToMocks() {
    Repository().addMockEntity<E>(defaultEntity);
  }

  /// Is used by, and has little use outside of, the framework. It is used by the
  /// testSynchronizeWithRepo test helper to test a provided entity combining method.
  @visibleForTesting
  E runEntityCombiner<T extends Entity>(T combineWith) {
    if (_entityCombiners.containsKey(T)) {
      return _entityCombiners[T]!.call(combineWith);
    } else {
      throw _entityCombinerMissing();
    }
  }
}

Exception _entityCombinerMissing() {
  return Exception('runEntityCombiner was called with a Type which has no combiner');
}
