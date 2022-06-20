import 'package:simple_framework/simple_framework.dart';

import 'test_service_model.dart';

class BrokenServiceModel extends ServiceModel {
  final int value;

  BrokenServiceModel({
    this.value = 0,
  });

  @override
  BrokenServiceModel merge({
    int? value,
  }) {
    return BrokenServiceModel(
      value: value ?? this.value,
    );
  }

  @override
  Future<ServiceModel> load() async {
    // Returns the wrong model type.
    return TestServiceModel();
  }
}
