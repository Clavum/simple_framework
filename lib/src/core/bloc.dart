//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  /// The value to use when the Bloc's associated Entity is fetched but doesn't yet exist. Needs to
  /// be provided in a call to super in the Bloc's constructor.
  final E defaultEntity;

  Bloc(this.defaultEntity);

  /// Shortcut to getting the Bloc's associated Entity.
  E get entity => Repository().get(defaultEntity);

  /// Optional method to override, to trigger events when the Screen (and Bloc) are first created.
  void onCreate() {}

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void dispose() {}

  /// Is used by, and has little use outside of, the framework. It is used to automatically set up
  /// the mock entity inside of bloc test groups using the default entity.
  @visibleForTesting
  void addEntityToMocks() {
    Repository().addMockEntity<E>(defaultEntity);
  }
}
