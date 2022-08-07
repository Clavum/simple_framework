// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'empty.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _emptyEntityBypassError = UnsupportedError(
  'EmptyEntity\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$EmptyEntity {
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

$EmptyEntityModifier get emptyEntity => $EmptyEntityModifier();

set emptyEntity(EmptyEntity model) => Repository().set(model);

/// @nodoc
class $EmptyEntityModifier extends _$_EmptyEntity {
  EmptyEntity get _model => Repository().get(const EmptyEntity());

  void send() => Repository().sendModel(_model);
}

final _emptyViewModelBypassError = UnsupportedError(
  'EmptyViewModel\'s constructor was bypassed by another constructor.',
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
