//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  /// The value to use when the Bloc's associated Entity is fetched but doesn't yet exist. Needs to
  /// be provided in a call to super in the Bloc's constructor.
  final E defaultEntity;

  /// List of Entity streams so that need to be disposed later.
  final List<StreamSubscription<void>> _entitySubscriptions = [];

  /// List of entity combiners provided from synchronization methods. Used only by the framework
  /// to allow easily testing a combiner.
  final Map<Type, Function> _entityCombiners = {};

  Bloc(this.defaultEntity);

  /// Shortcut to getting the Bloc's associated Entity.
  E get entity => Repository().get(defaultEntity);

  /// When an Entity of Type [T] is streamed, [entityCombiner] is called and provided this new
  /// Entity. The combiner is expected to return an instance of the Bloc's associated Entity which
  /// is updated to include some or all of the fields from the synced Entity, so that it can be sent
  /// as well.
  ///
  /// For example, say `ScreenEntity` has a field `exampleValue`, which is expected to be
  /// synchronized with the field `value` in the Entity named `ExampleEntity`. The following will
  /// accomplish this:
  ///
  /// ```dart
  /// synchronizeWithRepo(ScreenEntity(), (ExampleEntity exampleEntity) {
  ///   return entity.merge(exampleValue: exampleEntity.value);
  /// });
  /// ```
  ///
  /// Now, as ExampleEntity is updated (from any Bloc, at any point in time), the ScreenEntity will
  /// stay synchronized with these updates and the ScreenEntity will be sent to its Screen(s) as
  /// well.
  ///
  /// This method MUST be called in the onCreate method of a Bloc. When its associated Screen is
  /// first built, this method will be called *before* the Screen is built so that the Screen only
  /// ever displays up-to-date data.
  void synchronizeWithRepo<T extends Entity>(T initialEntity, Entity Function(T) entityCombiner) {
    _entityCombiners[T] = entityCombiner;
    Repository().set<E>(entityCombiner(Repository().get(initialEntity)) as E);
    _entitySubscriptions.add(
      Repository().streamOf<T>().listen((balanceEntity) {
        entityCombiner(Repository().get(balanceEntity)).send();
      }),
    );
  }

  /// Optional method to override, to trigger events when the Screen (and Bloc) are first created.
  void onCreate() {}

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
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
