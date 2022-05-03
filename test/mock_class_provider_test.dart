import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class MockExampleClass extends Mock implements ExampleClass {}

class ExampleClass {
  ExampleClass._();

  factory ExampleClass({bool allowMock = true}) {
    return MockClassProvider().get(
      real: ExampleClass._(),
      mock: MockExampleClass(),
      allowMock: allowMock,
    );
  }
}

void main() {
  test('MockClassProvider test', () {
    expect(ExampleClass().runtimeType, MockExampleClass);
    MockClassProvider().clearClasses();
    expect(ExampleClass(allowMock: false).runtimeType, ExampleClass);
  });
}