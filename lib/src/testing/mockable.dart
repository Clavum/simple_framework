import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

/// See [Mockable.getClass] for more information.
///
/// A shortcut to:
/// `Mockable().getClass(() => SomeClass._());`
/// Instead, it's:
/// `mockable(() => SomeClass._());`
T Function<T extends Object>(T Function() real) get mockable {
  return <T extends Object>(T Function() real) => Mockable().getClass(real);
}

/// See [Mockable.getClass] for more information.
///
/// A shortcut to:
/// `Mockable().setMock<SomeClass>(SomeClassMock());`
/// Instead, it's:
/// `setMock<SomeClass>(SomeClassMock());`
void Function<T extends Object>(Object mock) get setMock {
  return <T extends Object>(Object mock) => Mockable().setMock<T>(mock);
}

/// See [Mockable.clear] for more information.
///
/// A shortcut to:
/// `Mockable().clear();`
/// Instead, it's:
/// `clearAllMocks();`
void Function() get clearAllMocks {
  return () => Mockable().clear();
}

class Mockable {
  Mockable._();

  static Mockable? _instance;

  final Map<Type, Object> _mocks = {};

  factory Mockable() {
    _instance ??= Mockable._();
    return _instance!;
  }

  /// Returns a mock if one has been set, otherwise returns the real instance.
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
    return (_mocks[T] ?? real()) as T;
  }

  /// Used to mock a class. It will only work if the class uses [mockable] in
  /// its constructor.
  /// A type argument must be provided, which the class which you want to mock.
  /// A parameter must also be provided, which is the mock instance.
  /// For example:
  /// `setMock<ClassToMock>(MockInstance());`
  @visibleForTesting
  void setMock<T extends Object>(Object mock) {
    if (mock is! T) {
      throw _incompatibleMockError<T>(mock);
    }
    if (mock is! Mock && mock is! Fake) {
      throw _setMockUsedWithRealClassError(mock);
    }
    _mocks[T] = mock;
  }

  void clear() {
    _instance = null;
  }
}

ArgumentError _incompatibleMockError<T extends Object>(Object mock) {
  return ArgumentError('${mock.runtimeType} is not a $T');
}

ArgumentError _setMockUsedWithRealClassError(Object mock) {
  return ArgumentError(
    '''
${mock.runtimeType} is not a Mock or a Fake.
You cannot use setMock with a real class.
''',
  );
}
