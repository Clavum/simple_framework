// ignore_for_file: type=lint
// coverage:ignore-file

part of 'empty.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _emptyEntityBypassError = UnsupportedError(
  "EmptyEntity's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$EmptyEntity {
  static const _sentinel = Object();

  EmptyEntity merge() {
    throw _emptyEntityBypassError;
  }

  List<Object?> get props => throw _emptyEntityBypassError;
}

/// @nodoc
class _$_EmptyEntity extends _EmptyEntity {
  const _$_EmptyEntity() : super._();

  @override
  List<Object?> get props => [];

  @override
  _EmptyEntity merge() {
    return _EmptyEntity();
  }

  @override
  Type get runtimeType => EmptyEntity;
}

/// @nodoc
abstract class _EmptyEntity extends EmptyEntity {
  const factory _EmptyEntity() = _$_EmptyEntity;

  const _EmptyEntity._() : super._();
}

/// Looking for your model's code? You can go-to-source of this: [EmptyEntity].
EmptyEntity get emptyEntity => $EmptyEntityModifier();

set emptyEntity(EmptyEntity model) => Repository().set(model);

/// @nodoc
class $EmptyEntityModifier extends _$_EmptyEntity {
  final EmptyEntity Function()? _getOverride;
  final void Function(EmptyEntity)? _setOverride;
  final void Function(bool)? _sendOverride;

  const $EmptyEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  EmptyEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const EmptyEntity());

  void _set(EmptyEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send({bool silent = false}) => (_sendOverride != null)
      ? _sendOverride!.call(silent)
      : Repository().sendModel(_get, silent: silent);

  @override
  _EmptyEntity merge() {
    return this;
  }
}

final _emptyViewModelBypassError = UnsupportedError(
  "EmptyViewModel's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$EmptyViewModel {
  List<Object?> get props => throw _emptyViewModelBypassError;
}

/// @nodoc
class _$_EmptyViewModel extends _EmptyViewModel {
  const _$_EmptyViewModel() : super._();

  @override
  List<Object?> get props => [];

  @override
  Type get runtimeType => EmptyViewModel;
}

/// @nodoc
abstract class _EmptyViewModel extends EmptyViewModel {
  const factory _EmptyViewModel() = _$_EmptyViewModel;

  const _EmptyViewModel._() : super._();
}
