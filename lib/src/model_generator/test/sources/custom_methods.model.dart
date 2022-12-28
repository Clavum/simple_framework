// ignore_for_file: prefer_const_constructors, unused_element, sort_constructors_first, library_private_types_in_public_api
// coverage:ignore-file

part of 'custom_methods.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _customMethodsEntityBypassError = UnsupportedError(
  "CustomMethodsEntity's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$CustomMethodsEntity {
  int get value => throw _customMethodsEntityBypassError;

  set value(int value) => throw _customMethodsEntityBypassError;

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

/// Looking for your model's code? You can go-to-source of this: [CustomMethodsEntity].
$CustomMethodsEntityModifier get customMethodsEntity => $CustomMethodsEntityModifier();

set customMethodsEntity(CustomMethodsEntity model) => Repository().set(model);

/// @nodoc
class $CustomMethodsEntityModifier extends _$_CustomMethodsEntity {
  final CustomMethodsEntity Function()? _getOverride;
  final void Function(CustomMethodsEntity)? _setOverride;
  final void Function(bool)? _sendOverride;

  const $CustomMethodsEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  CustomMethodsEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const CustomMethodsEntity());

  void _set(CustomMethodsEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send({bool silent = false}) => (_sendOverride != null)
      ? _sendOverride!.call(silent)
      : Repository().sendModel(_get, silent: silent);

  @override
  int get value => _get.value;

  @override
  set value(int value) => _set(_get.merge(value: value));

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
  "CustomMethodsViewModel's constructor was bypassed by another constructor.",
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
