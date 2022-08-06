// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'custom_methods.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _customMethodsEntityBypassError = UnsupportedError(
  'CustomMethodsEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$CustomMethodsEntity {
  int get value => throw _customMethodsEntityBypassError;

  CustomMethodsEntity merge({
    int? value,
  }) {
    throw _customMethodsEntityBypassError;
  }

  List<Object?> get props => throw _customMethodsEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_CustomMethodsEntity extends _CustomMethodsEntity {
  const _$_CustomMethodsEntity({
    this.value = 0,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int value;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        value,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _CustomMethodsEntity merge({
    int? value,
  }) {
    return _CustomMethodsEntity(
      value: value ?? this.value,
    );
  }

  @override
  Type get runtimeType => CustomMethodsEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _CustomMethodsEntity extends CustomMethodsEntity {
  const factory _CustomMethodsEntity({
    int value,
  }) = _$_CustomMethodsEntity;

  const _CustomMethodsEntity._() : super._();

  @override
  int get value;
}

$CustomMethodsEntityModifier get customMethodsEntity => $CustomMethodsEntityModifier();

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class $CustomMethodsEntityModifier {
  CustomMethodsEntity get _model => Repository().get(const CustomMethodsEntity());

  void send() => Repository().sendModel(_model);

  void set(CustomMethodsEntity model) => Repository().set(model);

  CustomMethodsEntity get() => _model;

  int get value => _model.value;

  set value(int value) => Repository().set(_model.merge(value: value));
}

final _customMethodsViewModelBypassError = UnsupportedError(
  'CustomMethodsViewModel\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$CustomMethodsViewModel {
  int get value => throw _customMethodsViewModelBypassError;

  List<Object?> get props => throw _customMethodsViewModelBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_CustomMethodsViewModel extends _CustomMethodsViewModel {
  const _$_CustomMethodsViewModel({
    this.value = 0,
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
  Type get runtimeType => CustomMethodsViewModel;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _CustomMethodsViewModel extends CustomMethodsViewModel {
  const factory _CustomMethodsViewModel({
    int value,
  }) = _$_CustomMethodsViewModel;

  const _CustomMethodsViewModel._() : super._();

  @override
  int get value;
}
