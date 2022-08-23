import 'package:simple_framework/simple_framework.dart';

part 'person_model.model.dart';

@generateModel
class PersonModel extends Model with _$PersonModel {
  const PersonModel._();

  const factory PersonModel({
    required String firstName,
    required String lastName,
  }) = _PersonModel;

  // See usage below. This is one of the only ways to allow using a model that has required values
  // as a parameter of an entity, without using an iterable.
  // I test this scenario for completeness, but if you find yourself using this method, you should
  // question why your parameters are required in the first place.
  static const defaultInstance = PersonModel(
    firstName: 'Jojo',
    lastName: 'Loosingbeef',
  );
}

@generateEntity
class UsesModelEntity extends Entity with _$UsesModelEntity {
  const UsesModelEntity._();

  const factory UsesModelEntity({
    @Default([]) List<PersonModel> people,
    @Default(PersonModel.defaultInstance) PersonModel person,
  }) = _UsesModelEntity;
}
