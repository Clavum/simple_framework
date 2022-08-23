import 'package:flutter_test/flutter_test.dart';

import 'sources/person_model.dart';

void main() {
  test('can use models inside an Entity', () {
    usesModelEntity.people.add(
      const PersonModel(
        firstName: 'Josephius',
        lastName: 'Augustus',
      ),
    );
    usesModelEntity.people.add(
      const PersonModel(
        firstName: 'Yosef',
        lastName: 'Hosef-Wosef',
      ),
    );
    expect(usesModelEntity.people.length, 2);
    expect(usesModelEntity.people[0].firstName, 'Josephius');

    expect(usesModelEntity.person, PersonModel.defaultInstance);
    usesModelEntity.person = const PersonModel(
      firstName: 'Jospeh',
      lastName: 'Wninginhma',
    );
    expect(usesModelEntity.person.firstName, 'Jospeh');
  });
}
