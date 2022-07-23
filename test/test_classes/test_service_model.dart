import 'package:simple_framework/simple_framework.dart';

enum TestServiceModelState {
  defaultValue,
  fromLoad,
  fromRepository,
}

class TestServiceModel extends ServiceModel {
  final int value;
  final TestServiceModelState state;

  const TestServiceModel({
    this.value = 0,
    this.state = TestServiceModelState.defaultValue,
  });

  @override
  TestServiceModel merge({
    int? value,
    TestServiceModelState? state,
  }) {
    return TestServiceModel(
      value: value ?? this.value,
      state: state ?? this.state,
    );
  }

  @override
  Future<TestServiceModel> load() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const TestServiceModel(
      state: TestServiceModelState.fromLoad,
    );
  }
}
