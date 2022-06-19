import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class MockExampleClass extends Mock implements ExampleClass {}

class ExampleClass {
  ExampleClass._();

  factory ExampleClass({bool allowMock = true}) {
    return MockClassProvider().getMockIfTest(
      real: ExampleClass._(),
      mock: MockExampleClass(),
      allowMock: allowMock,
    );
  }
}

void main() {
  test('MockClassProvider getMockIfTest', () {
    expect(ExampleClass().runtimeType, MockExampleClass);
    MockClassProvider().clear();
    expect(ExampleClass(allowMock: false).runtimeType, ExampleClass);
  });

  test('MockClassProvider real classes are singletons', () {
    expect(ExampleClass(allowMock: false).hashCode, ExampleClass(allowMock: false).hashCode);
  });

  test('MockClassProvider mock classes are singletons', () {
    expect(ExampleClass().hashCode, ExampleClass().hashCode);
  });

  test('MockClassProvider setClass', () {
    ExampleClass real = ExampleClass._();
    MockClassProvider().setClass(real);
    expect(ExampleClass().hashCode, real.hashCode);
  });

  test('MockClassProvider forceUseRealClass', () {
    MockClassProvider().forceUseRealClass<ExampleClass>();
    expect(ExampleClass().runtimeType, ExampleClass);
    expect(ExampleClass().hashCode, ExampleClass().hashCode);
  });
}
