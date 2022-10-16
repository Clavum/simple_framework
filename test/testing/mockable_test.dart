import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/src/testing/mockable.dart';

class ExampleClass {
  ExampleClass._();

  factory ExampleClass() {
    return mockable(ExampleClass._);
  }

  int getValue() {
    return 1;
  }
}

class ExampleClassMock extends Mock implements ExampleClass {
  ExampleClassMock(int mockReturnValue) {
    when(getValue).thenAnswer((_) => mockReturnValue);
  }
}

class ExceptionIfConstructed {
  ExceptionIfConstructed._() {
    throw Exception();
  }

  factory ExceptionIfConstructed() {
    return mockable(ExceptionIfConstructed._);
  }
}

class ExceptionIfConstructedMock extends Mock
    implements ExceptionIfConstructed {}

void main() {
  tearDown(() {
    clearAllMocks();
  });

  test('basic Mockable test', () {
    // Not mocked, returns value defined in the class.
    expect(ExampleClass().getValue(), 1);

    // Set the class as mocked, so now the mock value is returned.
    setMock(ExampleClassMock(5));
    expect(ExampleClass().getValue(), 5);

    // Setting a mock a second time will override the previous mock.
    setMock(ExampleClassMock(10));
    expect(ExampleClass().getValue(), 10);

    // After clearing the mocks, the real value should be returned again.
    clearAllMocks();
    expect(ExampleClass().getValue(), 1);
  });

  test('same mock is returned every call', () {
    // It's very important that if a class is mocked, each call to get the class
    // will return the exact same mock instance. Otherwise, methods like
    // verify() will not work because the call was made on another mock.
    setMock(ExampleClassMock(5));
    expect(ExampleClass(), ExampleClass());
  });

  test('uses lazy loading', () {
    // When a class is mocked, it should not construct an instance of the
    // mocked class. It would be unnecessary and wasteful of resources to do
    // so.
    // The ExceptionIfConstructed class does what its name describes. This test
    // should pass because the class is mocked, so the mock is the only class
    // constructed during execution.
    setMock(ExceptionIfConstructedMock());
    ExceptionIfConstructed();
  });
}
