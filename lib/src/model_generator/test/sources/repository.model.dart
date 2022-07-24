// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

part of 'repository.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _repositoryEntityBypassError = UnsupportedError(
  'RepositoryEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$RepositoryEntity {
  int get intValue => throw _repositoryEntityBypassError;

  List<int> get listValue => throw _repositoryEntityBypassError;

  set intValue(int intValue) => throw _repositoryEntityBypassError;

  set listValue(List<int> listValue) => throw _repositoryEntityBypassError;

  RepositoryEntity merge({
    int? intValue,
    List<int>? listValue,
  }) {
    throw _repositoryEntityBypassError;
  }

  List<Object?> get props => throw _repositoryEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_RepositoryEntity extends _RepositoryEntity {
  const _$_RepositoryEntity({
    this.intValue = 0,
    this.listValue = const [],
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int intValue;
  @override
  final List<int> listValue;

  @override
  set intValue(int intValue) => Repository().set(merge(intValue: intValue));

  @override
  set listValue(List<int> listValue) => Repository().set(merge(listValue: listValue));

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        intValue,
        listValue,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _RepositoryEntity merge({
    int? intValue,
    List<int>? listValue,
  }) {
    return _RepositoryEntity(
      intValue: intValue ?? this.intValue,
      listValue: listValue ?? this.listValue,
    );
  }

  @override
  Type get runtimeType => RepositoryEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _RepositoryEntity extends RepositoryEntity {
  const factory _RepositoryEntity({
    int intValue,
    List<int> listValue,
  }) = _$_RepositoryEntity;

  const _RepositoryEntity._() : super._();

  @override
  int get intValue;

  @override
  List<int> get listValue;
}

RepositoryEntity get repositoryEntity => Repository().get(const RepositoryEntity());
