import 'package:simple_framework/simple_framework.dart';

class TestEntity extends Entity {
  final int value;
  final int buildCallCount;
  final int extraneousField;

  const TestEntity({
    this.value = 0,
    this.buildCallCount = 0,
    this.extraneousField = 0,
  });

  TestEntity merge({
    int? value,
    int? buildCallCount,
    int? extraneousField,
  }) {
    return TestEntity(
      value: value ?? this.value,
      buildCallCount: buildCallCount ?? this.buildCallCount,
      extraneousField: extraneousField ?? this.extraneousField,
    );
  }

  @override
  List<Object?> get props => [
        value,
        buildCallCount,
        extraneousField,
      ];
}

TestEntity get testEntity => Repository().get(const TestEntity());
