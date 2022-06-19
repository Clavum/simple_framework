import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class TestEntity extends Entity {
  final int value;

  const TestEntity({this.value = 0});

  @override
  TestEntity merge({int? value}) {
    return TestEntity(value: value ?? this.value);
  }
}

void main() {
  test('Entity send', () {
    TestEntity testEntity = const TestEntity(value: 1);
    testEntity.send();

    verify(() => Repository().sendModel(testEntity)).called(1);
  });
}
