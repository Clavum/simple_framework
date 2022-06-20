import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class MockExampleClass extends Mock implements ExampleClass {}

class ExampleClass {
  ExampleClass._();

  factory ExampleClass({bool allowMock = true}) {
    return MockClassProvider().getMockIfTest(
      real: () => ExampleClass._(),
      mock: () => MockExampleClass(),
      allowMock: allowMock,
    );
  }
}

void main() {
  group('MockClassProvider', () {
    test('getMockIfTest', () {
      expect(ExampleClass().runtimeType, MockExampleClass);
      MockClassProvider().clear();
      expect(ExampleClass(allowMock: false).runtimeType, ExampleClass);
    });

    test('real classes are singletons', () {
      expect(ExampleClass(allowMock: false).hashCode, ExampleClass(allowMock: false).hashCode);
    });

    test('mock classes are singletons', () {
      expect(ExampleClass().hashCode, ExampleClass().hashCode);
    });

    test('setClass', () {
      ExampleClass real = ExampleClass._();
      MockClassProvider().setClass(real);
      expect(ExampleClass().hashCode, real.hashCode);
    });

    test('forceUseRealClass', () {
      MockClassProvider().forceUseRealClass<ExampleClass>();
      expect(ExampleClass().runtimeType, ExampleClass);
      expect(ExampleClass().hashCode, ExampleClass().hashCode);
    });
  });
}
