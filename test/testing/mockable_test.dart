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
  ExampleClassMock() {
    when(() => getValue()).thenAnswer((_) => 5);
  }
}

void main() {
  test('mockable', () {
    expect(ExampleClass().getValue(), 1);

    setMock<ExampleClass>(ExampleClassMock());

    expect(ExampleClass().getValue(), 5);

    clearAllMocks();

    expect(ExampleClass().getValue(), 1);
  });
}
