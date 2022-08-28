import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_entity.dart';

void main() {
  test('Entity send', () {
    final RepositoryMock repositoryMock = RepositoryMock();
    setMock(repositoryMock);
    final TestEntity testEntity = const TestEntity(value: 1)..send();

    verify(() => repositoryMock.sendModel(testEntity)).called(1);
  });
}
