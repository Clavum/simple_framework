import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../simple_classes/test_entity.dart';

void main() {
  // Unit test which creates RepositoryMock and expects error from get method.
  test('mockable', () {
    var repositoryMock = RepositoryMock();

    /// Uses default values by default. Set goes first to make sure it doesn't actually set
    /// anything.
    expect(repositoryMock.set(const TestEntity()).value, 0);
    expect(repositoryMock.get(const TestEntity()).value, 0);

    /// Uses mock values once set.
    repositoryMock.addMockModel(const TestEntity(value: 2));
    expect(repositoryMock.set(const TestEntity()).value, 2);
    expect(repositoryMock.get(const TestEntity()).value, 2);

    /// Can set again to override last value.
    repositoryMock.addMockModel(const TestEntity(value: 5));
    expect(repositoryMock.set(const TestEntity()).value, 5);
    expect(repositoryMock.get(const TestEntity()).value, 5);
  });
}
