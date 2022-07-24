// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

part of 'success.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _entitySuccessBypassError = UnsupportedError(
  'EntitySuccess\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$EntitySuccess {
  String get defaultParameter => throw _entitySuccessBypassError;

  bool? get nullableParameter => throw _entitySuccessBypassError;

  CustomClass get customClass => throw _entitySuccessBypassError;

  set defaultParameter(String defaultParameter) => throw _entitySuccessBypassError;

  set nullableParameter(bool? nullableParameter) => throw _entitySuccessBypassError;

  set customClass(CustomClass customClass) => throw _entitySuccessBypassError;

  EntitySuccess merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    throw _entitySuccessBypassError;
  }

  List<Object?> get props => throw _entitySuccessBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_EntitySuccess extends _EntitySuccess {
  const _$_EntitySuccess({
    this.defaultParameter = 'defaultValue',
    this.nullableParameter,
    this.customClass = const CustomClass('custom'),
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final String defaultParameter;
  @override
  final bool? nullableParameter;
  @override
  final CustomClass customClass;

  @override
  set defaultParameter(String defaultParameter) =>
      Repository().set(merge(defaultParameter: defaultParameter));

  @override
  set nullableParameter(bool? nullableParameter) =>
      Repository().set(merge(nullableParameter: nullableParameter));

  @override
  set customClass(CustomClass customClass) => Repository().set(merge(customClass: customClass));

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        defaultParameter,
        nullableParameter,
        customClass,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _EntitySuccess merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    return _EntitySuccess(
      defaultParameter: defaultParameter ?? this.defaultParameter,
      nullableParameter: nullableParameter ?? this.nullableParameter,
      customClass: customClass ?? this.customClass,
    );
  }

  @override
  Type get runtimeType => EntitySuccess;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _EntitySuccess extends EntitySuccess {
  const factory _EntitySuccess({
    String defaultParameter,
    bool? nullableParameter,
    CustomClass customClass,
  }) = _$_EntitySuccess;

  const _EntitySuccess._() : super._();

  @override
  String get defaultParameter;

  @override
  bool? get nullableParameter;

  @override
  CustomClass get customClass;
}

EntitySuccess get entitySuccess => Repository().get(const EntitySuccess());

final _viewModelSuccessBypassError = UnsupportedError(
  'ViewModelSuccess\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$ViewModelSuccess {
  String get defaultParameter => throw _viewModelSuccessBypassError;

  int get requiredParameter => throw _viewModelSuccessBypassError;

  bool? get nullableParameter => throw _viewModelSuccessBypassError;

  List<Object?> get props => throw _viewModelSuccessBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_ViewModelSuccess extends _ViewModelSuccess {
  const _$_ViewModelSuccess({
    this.defaultParameter = 'defaultValue',
    required this.requiredParameter,
    this.nullableParameter,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final String defaultParameter;
  @override
  final int requiredParameter;
  @override
  final bool? nullableParameter;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        defaultParameter,
        requiredParameter,
        nullableParameter,
      ];

  @override
  Type get runtimeType => ViewModelSuccess;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _ViewModelSuccess extends ViewModelSuccess {
  const factory _ViewModelSuccess({
    String defaultParameter,
    required int requiredParameter,
    bool? nullableParameter,
  }) = _$_ViewModelSuccess;

  const _ViewModelSuccess._() : super._();

  @override
  String get defaultParameter;

  @override
  int get requiredParameter;

  @override
  bool? get nullableParameter;
}

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

EmptyEntity get emptyEntity => Repository().get(const EmptyEntity());

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
