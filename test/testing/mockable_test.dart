import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/src/testing/mockable.dart';

class ExampleClass {
  ExampleClass._();

  factory ExampleClass() {
    return mockable(() => ExampleClass._());
  }

  int getValue() {
    return 1;
  }
}

class ExampleClassMock extends Mock implements ExampleClass {
  ExampleClassMock(int mockReturnValue) {
    when(() => getValue()).thenAnswer((_) => mockReturnValue);
  }
}

void main() {
  test('mockable', () {
    // Not mocked, returns value defined in the class.
    expect(ExampleClass().getValue(), 1);

    // Set the class as mocked, so now the mock value is returned.
    setMock<ExampleClass>(ExampleClassMock(5));
    expect(ExampleClass().getValue(), 5);

    // Setting a mock a second time will override the previous mock.
    setMock<ExampleClass>(ExampleClassMock(10));
    expect(ExampleClass().getValue(), 10);

    // After clearing the mocks, the real value should be returned again.
    clearAllMocks();
    expect(ExampleClass().getValue(), 1);
  });

  test('with TypeError', () {
    expect(() => setMock<String>(ExampleClassMock(5)), throwsArgumentError);
  });

  test('with invalid mock', () {
    expect(() => setMock<ExampleClass>(ExampleClass()), throwsArgumentError);
  });
}
