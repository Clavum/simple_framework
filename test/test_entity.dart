import 'package:simple_framework/simple_framework.dart';

class TestEntity extends Entity {
  final int value;

  const TestEntity({this.value = 0});

  @override
  TestEntity merge({int? value}) {
    return TestEntity(value: value ?? this.value);
  }
}
