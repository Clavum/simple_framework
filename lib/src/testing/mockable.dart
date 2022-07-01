import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

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
    for (var mock in _mocks.values) {
      if (mock is T) return mock;
    }
    return real();
  }

  /// Used to mock a class. It will only work if the class uses [mockable] in
  /// a factory constructor. The target class to mock is inferred by which class
  /// the mock implements.
  @visibleForTesting
  void setMock<T extends Object>(T mock) {
    if (mock is! Mock && mock is! Fake) {
      throw _setMockUsedWithRealClassError(mock);
    }
    setupCommonMockStubs(mock);
    _mocks[T] = (mock);
  }

  void clear() {
    _instance = null;
  }
}

ArgumentError _setMockUsedWithRealClassError(Object mock) {
  return ArgumentError(
    '''
${mock.runtimeType} is not a Mock or a Fake.
You cannot use setMock with a real class.
''',
  );
}
