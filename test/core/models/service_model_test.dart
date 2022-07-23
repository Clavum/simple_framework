import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_service_model.dart';

void main() {
  test('ServiceModel send', () {
    RepositoryMock repositoryMock = RepositoryMock();
    setMock(repositoryMock);
    TestServiceModel testServiceModel = const TestServiceModel(value: 1);
    testServiceModel.send();

    verify(() => repositoryMock.sendModel(testServiceModel)).called(1);
  });
}
