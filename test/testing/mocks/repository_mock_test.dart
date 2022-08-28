import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_entity.dart';

void main() {
  test('mockable', () {
    final repositoryMock = RepositoryMock()..addMockModel(const TestEntity(value: 2));

    /// Uses mock values once set.
    expect(repositoryMock.set(const TestEntity()).value, 2);
    expect(repositoryMock.get(const TestEntity()).value, 2);

    /// Can set again to override last value.
    repositoryMock.addMockModel(const TestEntity(value: 5));
    expect(repositoryMock.set(const TestEntity()).value, 5);
    expect(repositoryMock.get(const TestEntity()).value, 5);
  });
}
