// ignore_for_file: type=lint
// coverage:ignore-file

part of 'person_model.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _personModelBypassError = UnsupportedError(
  "PersonModel's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$PersonModel {
  String get firstName => throw _personModelBypassError;

  String get lastName => throw _personModelBypassError;

  PersonModel merge({
    String? firstName,
    String? lastName,
  }) {
    throw _personModelBypassError;
  }

  List<Object?> get props => throw _personModelBypassError;
}

/// @nodoc
class _$_PersonModel extends _PersonModel {
  const _$_PersonModel({
    required this.firstName,
    required this.lastName,
  }) : super._();

  @override
  final String firstName;
  @override
  final String lastName;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
      ];

  @override
  _PersonModel merge({
    String? firstName,
    String? lastName,
  }) {
    return _PersonModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  Type get runtimeType => PersonModel;
}

/// @nodoc
abstract class _PersonModel extends PersonModel {
  const factory _PersonModel({
    required String firstName,
    required String lastName,
  }) = _$_PersonModel;

  const _PersonModel._() : super._();

  @override
  String get firstName;

  @override
  String get lastName;
}

final _usesModelEntityBypassError = UnsupportedError(
  "UsesModelEntity's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$UsesModelEntity {
  List<PersonModel> get people => throw _usesModelEntityBypassError;

  PersonModel get person => throw _usesModelEntityBypassError;

  set people(List<PersonModel> people) => throw _usesModelEntityBypassError;

  set person(PersonModel person) => throw _usesModelEntityBypassError;

  UsesModelEntity merge({
    List<PersonModel>? people,
    PersonModel? person,
  }) {
    throw _usesModelEntityBypassError;
  }

  List<Object?> get props => throw _usesModelEntityBypassError;
}

/// @nodoc
class _$_UsesModelEntity extends _UsesModelEntity {
  static const List<PersonModel> $peopleDefaultValue = [];

  const _$_UsesModelEntity({
    this.people = $peopleDefaultValue,
    this.person = PersonModel.defaultInstance,
  }) : super._();

  @override
  final List<PersonModel> people;
  @override
  final PersonModel person;

  @override
  List<Object?> get props => [
        people,
        person,
      ];

  @override
  _UsesModelEntity merge({
    List<PersonModel>? people,
    PersonModel? person,
  }) {
    return _UsesModelEntity(
      people: people ?? this.people,
      person: person ?? this.person,
    );
  }

  @override
  Type get runtimeType => UsesModelEntity;
}

/// @nodoc
abstract class _UsesModelEntity extends UsesModelEntity {
  const factory _UsesModelEntity({
    List<PersonModel> people,
    PersonModel person,
  }) = _$_UsesModelEntity;

  const _UsesModelEntity._() : super._();

  @override
  List<PersonModel> get people;

  @override
  PersonModel get person;
}

/// Looking for your model's code? You can go-to-source of this: [UsesModelEntity].
$UsesModelEntityModifier get usesModelEntity => $UsesModelEntityModifier();

set usesModelEntity(UsesModelEntity model) => Repository().set(model);

/// @nodoc
class $UsesModelEntityModifier extends _$_UsesModelEntity {
  final UsesModelEntity Function()? _getOverride;
  final void Function(UsesModelEntity)? _setOverride;
  final void Function(bool)? _sendOverride;

  const $UsesModelEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  UsesModelEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const UsesModelEntity());

  void _set(UsesModelEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send({bool silent = false}) => (_sendOverride != null)
      ? _sendOverride!.call(silent)
      : Repository().sendModel(_get, silent: silent);

  @override
  List<PersonModel> get people {
    final value = _get.people;
    return (value == _$_UsesModelEntity.$peopleDefaultValue && value != null)
        ? people = List.from(value)
        : value;
  }

  @override
  set people(List<PersonModel> people) => _set(_get.merge(people: people));

  @override
  PersonModel get person => _get.person;

  @override
  set person(PersonModel person) => _set(_get.merge(person: person));

  @override
  _UsesModelEntity merge({
    List<PersonModel>? people,
    PersonModel? person,
  }) {
    if (people != null) {
      this.people = people;
    }
    if (person != null) {
      this.person = person;
    }
    return this;
  }
}
