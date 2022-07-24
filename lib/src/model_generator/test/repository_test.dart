import 'package:simple_framework/simple_framework.dart';
import 'package:test/test.dart';

import 'sources/repository.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  test('using an Entity with the repository', () {
    // A global getter is generated and initially uses default value.
    expect(repositoryEntity.intValue, 0);

    // Returns the current instance in the Repository.
    Repository().set(const RepositoryEntity(intValue: 10));
    expect(repositoryEntity.intValue, 10);

    // Can set a new value.
    repositoryEntity.intValue = 123;
    expect(repositoryEntity.intValue, 123);
  });
}
