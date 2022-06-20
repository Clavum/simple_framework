import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class TestServiceModel extends ServiceModel {
  final int value;

  TestServiceModel({this.value = 0});

  @override
  TestServiceModel merge({int? value}) {
    return TestServiceModel(value: value ?? this.value);
  }

  @override
  Future<ServiceModel> load() async {
    return TestServiceModel();
  }
}

void main() {
  test('ServiceModel send', () {
    TestServiceModel testServiceModel = TestServiceModel(value: 1);
    testServiceModel.send();

    verify(() => Repository().sendModel(testServiceModel)).called(1);
  });
}
