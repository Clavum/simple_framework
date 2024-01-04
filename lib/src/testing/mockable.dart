import 'package:flutter/material.dart';

/// See [Mockable.getClass] for more information.
///
/// A shortcut to:
/// `Mockable().getClass(() => SomeClass._());`
/// Instead, it's:
/// `mockable(() => SomeClass._());`
T Function<T extends Object>(T Function() real) get mockable {
  return Mockable().getClass;
}

/// See [Mockable.setMock] for more information.
///
/// A shortcut to:
/// `Mockable().setMock(SomeClassMock());`
/// Instead, it's:
/// `setMock(SomeClassMock());`
void Function<T extends Object>(T mock) get setMock {
  return Mockable().setMock;
}

/// See [Mockable.removeMock] for more information.
///
/// A shortcut to:
/// `Mockable().removeMock<SomeClass>();`
/// Instead, it's:
/// `removeMock<SomeClass>();`
void Function<T extends Object>() get removeMock {
  return Mockable().removeMock;
}

/// See [Mockable.clear] for more information.
///
/// A shortcut to:
/// `Mockable().clear();`
/// Instead, it's:
/// `clearAllMocks();`
void Function() get clearAllMocks {
  return Mockable().clear;
}

class Mockable {
  Mockable._();

  static Mockable? _instance;

  final Map<Type, Object> _mocks = {};

  factory Mockable() {
    _instance ??= Mockable._();
    return _instance!;
  }

  /// Checks every mock which has been provided by [setMock] and returns the
  /// first one which extends the [real] class. If no matching mocks are found,
  /// the [real] instance is used.
  ///
  /// Consider using:
  /// `mockable(() => SomeClass())`
  /// as a shortcut to:
  /// `Mockable().getClass(() => SomeClass())`
  ///
  /// Notice the usage is:
  /// `mockable(() => SomeClass())`
  /// instead of:
  /// `mockable(SomeClass())`
  /// This is to allow lazy initialization. If the class has been mocked, then
  /// we can spare resources by not creating the real class.
  T getClass<T extends Object>(T Function() real) {
    for (final mock in _mocks.values) {
      if (mock is T) return mock;
    }
    return real();
  }

  /// Used to mock a class. It will only work if the class uses [mockable] in
  /// a factory constructor. The target class to mock is inferred by which class
  /// the mock implements.
  @visibleForTesting
  void setMock<T extends Object>(T mock) {
    _mocks[T] = mock;
  }

  /// Remove mocks of the given type, if any exist.
  /// You may use supertypes:
  /// `removeMock<Object>()` (removes all mocks)
  /// the class type:
  /// `removeMock<SomeClass>()`
  /// or the mock type:
  /// `removeMock<SomeClassMock>()` (same effect as above)
  void removeMock<T extends Object>() {
    _mocks.removeWhere((key, value) => value is T);
  }

  void clear() {
    _instance = null;
  }
}
