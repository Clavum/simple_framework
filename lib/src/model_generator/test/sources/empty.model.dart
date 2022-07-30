// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

part of 'empty.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _emptyEntityBypassError = UnsupportedError(
  'EmptyEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$EmptyEntity {
  EmptyEntity merge() {
    throw _emptyEntityBypassError;
  }

  List<Object?> get props => throw _emptyEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_EmptyEntity extends _EmptyEntity {
  const _$_EmptyEntity() : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _EmptyEntity merge() {
    return _EmptyEntity();
  }

  @override
  Type get runtimeType => EmptyEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _EmptyEntity extends EmptyEntity {
  const factory _EmptyEntity() = _$_EmptyEntity;

  const _EmptyEntity._() : super._();
}

_EmptyEntityModifier get emptyEntity => _EmptyEntityModifier();

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _EmptyEntityModifier {
  EmptyEntity get _model => Repository().get(const EmptyEntity());

  void send() => Repository().sendModel(_model);

  void set(EmptyEntity model) => Repository().set(model);

  EmptyEntity get() => _model;
}

final _emptyViewModelBypassError = UnsupportedError(
  'EmptyViewModel\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$EmptyViewModel {
  List<Object?> get props => throw _emptyViewModelBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_EmptyViewModel extends _EmptyViewModel {
  const _$_EmptyViewModel() : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [];

  @override
  Type get runtimeType => EmptyViewModel;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _EmptyViewModel extends EmptyViewModel {
  const factory _EmptyViewModel() = _$_EmptyViewModel;

  const _EmptyViewModel._() : super._();
}
