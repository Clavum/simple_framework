import 'package:flutter/material.dart';

/// A shortcut to:
/// ```dart
/// Mockable().getClass(SomeClass._());
/// ```
/// Instead, it's:
/// ```dart
/// mockable(SomeClass._());
/// ```
///
/// See [Mockable.getClass] for more information.
T Function<T extends Object>(T Function() real) get mockable {
  return <T extends Object>(T Function() real) => Mockable().getClass(real);
}

/// A shortcut to:
/// ```dart
/// Mockable().setMock<SomeClass>(SomeClassMock());
/// ```
/// Instead, it's:
/// ```dart
/// setMock<SomeClass>(SomeClassMock());
/// ```
///
/// See [Mockable.getClass] for more information.
void Function<T extends Object>(Object mock) get setMock {
  return <T extends Object>(Object mock) => Mockable().setMock<T>(mock);
}

/// A shortcut to:
/// ```dart
/// Mockable().clear();
/// ```
/// Instead, it's:
/// ```dart
/// clearAllMocks();
/// ```
/// See [Mockable.clear] for more information.
void Function() get clearAllMocks {
  return () => Mockable().clear();
}

// MockClassProvider's getMockIfTest was too uncontrolled. It is not clear to other developers that
// the class is automatically mocked. To get the same effect, just set up classes that need to be
// mocked in a setUp method.
// Additionally, mocks are often customized (such as setting a mock

class Mockable {
  Mockable._();

  static Mockable? _instance;

  final Map<Type, Object> _mocks = {};

  factory Mockable() {
    _instance ??= Mockable._();
    return _instance!;
  }

  /// Returns a mock if one has been set, otherwise returns the real instance.
  /// Consider using mockable(SomeClass()) instead of Mockable().getClass(SomeClass()).
  T getClass<T extends Object>(T Function() real) {
    return (_mocks[T] ?? real()) as T;
  }

  /// Used to make a class mocked. It will only work if the class uses [mockable] in its
  /// constructor.
  @visibleForTesting
  void setMock<T extends Object>(Object mock) {
    assert(T != Object, 'setMock must be provided a type parameter');
    _mocks[T] = mock;
  }

  void clear() {
    _instance = null;
  }
}
