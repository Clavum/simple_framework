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

  static final MockClassProvider _mockClassProvider = MockClassProvider._();

  final List<Object> _classes = [];

  factory MockClassProvider() {
    return _mockClassProvider;
  }

  /// Returns [real] if running real code, and returns [mock] if running a test.
  E getMockIfTest<E extends Object, M extends Object>({
    required E real,
    required M mock,
    bool allowMock = true,
  }) {
    return _classes.firstWhere(
      (object) => object.runtimeType == E || object.runtimeType == M,
      orElse: () {
        if (Platform.environment.containsKey('FLUTTER_TEST') && allowMock) {
          _classes.add(mock);
          return mock;
        } else {
          _classes.add(real);
          return real;
        }
      },
    ) as E;
  }

  @visibleForTesting
  void clearClasses() {
    _classes.clear();
  }

  @visibleForTesting
  void setClass(Object object) {
    _classes
        .retainWhere((element) => element.runtimeType != object.runtimeType);
    _classes.add(object);
  }
}