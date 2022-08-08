// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'basic.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _basicEntityBypassError = UnsupportedError(
  'BasicEntity\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$BasicEntity {
  int get value => throw _basicEntityBypassError;

  BasicEntity merge({
    int? value,
  }) {
    throw _basicEntityBypassError;
  }

  List<Object?> get props => throw _basicEntityBypassError;
}

/// @nodoc
class _$_BasicEntity extends _BasicEntity {
  const _$_BasicEntity({
    this.value = 0,
  }) : super._();

  @override
  final int value;

  @override
  List<Object?> get props => [
        value,
      ];

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

/// @nodoc
abstract class _BasicEntity extends BasicEntity {
  const factory _BasicEntity({
    int value,
  }) = _$_BasicEntity;

  const _BasicEntity._() : super._();

  @override
  int get value;
}

$BasicEntityModifier get basicEntity => $BasicEntityModifier();

set basicEntity(BasicEntity model) => Repository().set(model);

/// @nodoc
class $BasicEntityModifier extends _$_BasicEntity {
  final BasicEntity Function()? _getOverride;
  final void Function(BasicEntity)? _setOverride;
  final void Function()? _sendOverride;

  const $BasicEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  BasicEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const BasicEntity());

  void _set(BasicEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send() => (_sendOverride != null) ? _sendOverride!.call() : Repository().sendModel(_get);

  @override
  int get value => _get.value;

  set value(int value) => _set(_get.merge(value: value));

  @override
  _BasicEntity merge({
    int? value,
  }) {
    if (value != null) {
      this.value = value;
    }
    return this;
  }
}

final _basicViewModelBypassError = UnsupportedError(
  'BasicViewModel\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$BasicViewModel {
  int get value => throw _basicViewModelBypassError;

  List<Object?> get props => throw _basicViewModelBypassError;
}

/// @nodoc
class _$_BasicViewModel extends _BasicViewModel {
  const _$_BasicViewModel({
    required this.value,
  }) : super._();

  @override
  final int value;

  @override
  List<Object?> get props => [
        value,
      ];

  @override
  Type get runtimeType => BasicViewModel;
}

/// @nodoc
abstract class _BasicViewModel extends BasicViewModel {
  const factory _BasicViewModel({
    required int value,
  }) = _$_BasicViewModel;

  const _BasicViewModel._() : super._();

  @override
  int get value;
}
