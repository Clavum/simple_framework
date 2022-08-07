// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'custom_methods.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _customMethodsEntityBypassError = UnsupportedError(
  'CustomMethodsEntity\'s constructor was bypassed by another constructor.',
);

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

/// @nodoc
class _$_CustomMethodsEntity extends _CustomMethodsEntity {
  const _$_CustomMethodsEntity({
    this.value = 0,
  }) : super._();

  @override
  final int value;

  @override
  List<Object?> get props => [
        value,
      ];

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

set customMethodsEntity(CustomMethodsEntity model) => Repository().set(model);

/// @nodoc
class $CustomMethodsEntityModifier extends _$_CustomMethodsEntity {
  CustomMethodsEntity get _model => Repository().get(const CustomMethodsEntity());

  void send() => Repository().sendModel(_model);

  int get value => _model.value;

  set value(int value) => Repository().set(_model.merge(value: value));

  @override
  _CustomMethodsEntity merge({
    int? value,
  }) {
    if (value != null) {
      this.value = value;
    }
    return this;
  }
}

final _customMethodsViewModelBypassError = UnsupportedError(
  'CustomMethodsViewModel\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$CustomMethodsViewModel {
  int get value => throw _customMethodsViewModelBypassError;

  List<Object?> get props => throw _customMethodsViewModelBypassError;
}

/// @nodoc
class _$_CustomMethodsViewModel extends _CustomMethodsViewModel {
  const _$_CustomMethodsViewModel({
    this.value = 0,
  }) : super._();

  @override
  final int value;

  @override
  List<Object?> get props => [
        value,
      ];

  @override
  Type get runtimeType => CustomMethodsViewModel;
}

/// @nodoc
abstract class _CustomMethodsViewModel extends CustomMethodsViewModel {
  const factory _CustomMethodsViewModel({
    int value,
  }) = _$_CustomMethodsViewModel;

  const _CustomMethodsViewModel._() : super._();

  @override
  int get value;
}
