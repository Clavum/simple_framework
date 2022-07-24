// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

part of 'basic.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _basicEntityBypassError = UnsupportedError(
  'BasicEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$BasicEntity {
  int get value => throw _basicEntityBypassError;

  set value(int value) => throw _basicEntityBypassError;

  BasicEntity merge({
    int? value,
  }) {
    throw _basicEntityBypassError;
  }

  List<Object?> get props => throw _basicEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_BasicEntity extends _BasicEntity {
  const _$_BasicEntity({
    this.value = 0,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int value;

  @override
  set value(int value) => Repository().set(merge(value: value));

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        value,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _BasicEntity merge({
    int? value,
  }) {
    return _BasicEntity(
      value: value ?? this.value,
    );
  }

  @override
  Type get runtimeType => BasicEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _BasicEntity extends BasicEntity {
  const factory _BasicEntity({
    int value,
  }) = _$_BasicEntity;

  const _BasicEntity._() : super._();

  @override
  int get value;
}

BasicEntity get basicEntity => Repository().get(const BasicEntity());

final _basicViewModelBypassError = UnsupportedError(
  'BasicViewModel\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$BasicViewModel {
  int get value => throw _basicViewModelBypassError;

  List<Object?> get props => throw _basicViewModelBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_BasicViewModel extends _BasicViewModel {
  const _$_BasicViewModel({
    required this.value,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int value;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        value,
      ];

  @override
  Type get runtimeType => BasicViewModel;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _BasicViewModel extends BasicViewModel {
  const factory _BasicViewModel({
    required int value,
  }) = _$_BasicViewModel;

  const _BasicViewModel._() : super._();

  @override
  int get value;
}