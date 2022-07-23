import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_entity.dart';

void main() {
  test('Entity send', () {
    RepositoryMock repositoryMock = RepositoryMock();
    setMock(repositoryMock);
    TestEntity testEntity = const TestEntity(value: 1);
    testEntity.send();

    verify(() => repositoryMock.sendModel(testEntity)).called(1);
  });
}
