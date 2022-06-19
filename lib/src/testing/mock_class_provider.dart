import 'dart:io';

import 'package:flutter/material.dart';

/// Used to create 'Mock Factories' which provide real class instances while running the app but
/// mocked instances while running tests. Example:
///
/// ```dart
/// class MockExampleClass extends Mock implements ExampleClass {}
///
/// class ExampleClass {
///   ExampleClass._();
///
///   factory ExampleClass({bool allowMock = true}) {
///     return MockClassProvider().getMockIfTest(
///       real: ExampleClass._(),
///       mock: allowMock ? MockExampleClass() : ExampleClass._(),
///     );
///   }
/// }
/// ```
///
/// Now, in your unit tests, you no longer have to set up and clear mocks manually. Additionally, it
/// is a common practice to provide parameters in a class which allow you to replace dependencies
/// with mocks, but this is no longer necessary. Just reference ExampleClass() in real code and in
/// tests.
///
/// The MockClassProvider stores mock instances, so the instance returned by ExampleClass() will
/// always be identical. Otherwise, calling `verify()` or similar methods would never recognize a
/// method was called.
class MockClassProvider {
  MockClassProvider._();

  static MockClassProvider? _instance;

  final List<Object> _classes = [];

  final List<Type> _realOverrides = [];

  factory MockClassProvider() {
    _instance ??= MockClassProvider._();
    return _instance!;
  }

  /// Returns [real] if running real code, and returns [mock] if running a test.
  E getMockIfTest<E extends Object, M extends Object>({
    required E real,
    required M mock,
    bool allowMock = true,
  }) {
    if (_realOverrides.contains(E)) return real;
    return _classes.firstWhere(
      (object) => object.runtimeType == E || object.runtimeType == M,
      orElse: () {
        if (Platform.environment.containsKey('FLUTTER_TEST') && allowMock) {
          _classes.add(mock);
          return mock;
        } else {
          //TODO: Don't singleton-ify real classes.
          //They're singletons so that you can do Repository() many times and get the same instance.
          //I need to look into this more.
          _classes.add(real);
          return real;
        }
      },
    ) as E;
  }

  @visibleForTesting
  void setClass<O extends Object>(O object) {
    _classes.retainWhere((element) => element.runtimeType != object.runtimeType);
    _classes.add(object);
  }

  @visibleForTesting
  void forceUseRealClass<O extends Object>() {
    _realOverrides.retainWhere((element) => element.runtimeType != O);
    _realOverrides.add(O);
  }

  void clear() {
    _instance = null;
  }
}
