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
  });

  test('can update lists', () {
    repositoryEntity.listValue = [1, 2, 3];
    expect(repositoryEntity.listValue, [1, 2, 3]);

    repositoryEntity.listValue.add(4);
    expect(repositoryEntity.listValue, [1, 2, 3, 4]);

    repositoryEntity.listValue.clear();
    Repository().removeModel<RepositoryEntity>();
    expect(repositoryEntity.listValue, []);

    // TODO: The next section fails without this line below because of an UnmodifiableList error.
    // It has nothing to do with the Repository, since you get this error from doing:
    // RepositoryEntity().listValue.add(10);
    // but not:
    // RepositoryEntity(listValue: []).listValue.add(10);
    // I think it's because if you have an Entity without a listValue yet, you get the default
    // value of "const []", and for some reason this is unmodifiable.
    repositoryEntity.listValue = [];

    repositoryEntity.listValue.addAll([1, 2, 3]);
    expect(repositoryEntity.listValue, [1, 2, 3]);
  });
}
