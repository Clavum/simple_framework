import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_service_model.dart';

void main() {
  test('ServiceModel send', () {
    TestServiceModel testServiceModel = TestServiceModel(value: 1);
    testServiceModel.send();

    verify(() => Repository().sendModel(testServiceModel)).called(1);
  });
}
