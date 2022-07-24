// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

part of 'various_parameters.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _variousParametersEntityBypassError = UnsupportedError(
  'VariousParametersEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$VariousParametersEntity {
  String get defaultParameter => throw _variousParametersEntityBypassError;

  bool? get nullableParameter => throw _variousParametersEntityBypassError;

  CustomClass get customClass => throw _variousParametersEntityBypassError;

  set defaultParameter(String defaultParameter) => throw _variousParametersEntityBypassError;

  set nullableParameter(bool? nullableParameter) => throw _variousParametersEntityBypassError;

  set customClass(CustomClass customClass) => throw _variousParametersEntityBypassError;

  VariousParametersEntity merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    throw _variousParametersEntityBypassError;
  }

  List<Object?> get props => throw _variousParametersEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_VariousParametersEntity extends _VariousParametersEntity {
  const _$_VariousParametersEntity({
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
  _VariousParametersEntity merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    return _VariousParametersEntity(
      defaultParameter: defaultParameter ?? this.defaultParameter,
      nullableParameter: nullableParameter ?? this.nullableParameter,
      customClass: customClass ?? this.customClass,
    );
  }

  @override
  Type get runtimeType => VariousParametersEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _VariousParametersEntity extends VariousParametersEntity {
  const factory _VariousParametersEntity({
    String defaultParameter,
    bool? nullableParameter,
    CustomClass customClass,
  }) = _$_VariousParametersEntity;

  const _VariousParametersEntity._() : super._();

  @override
  String get defaultParameter;

  @override
  bool? get nullableParameter;

  @override
  CustomClass get customClass;
}

VariousParametersEntity get variousParametersEntity =>
    Repository().get(const VariousParametersEntity());

final _variousParametersViewModelBypassError = UnsupportedError(
  'VariousParametersViewModel\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$VariousParametersViewModel {
  String get defaultParameter => throw _variousParametersViewModelBypassError;

  int get requiredParameter => throw _variousParametersViewModelBypassError;

  bool? get nullableParameter => throw _variousParametersViewModelBypassError;

  CustomClass get customClass => throw _variousParametersViewModelBypassError;

  List<Object?> get props => throw _variousParametersViewModelBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_VariousParametersViewModel extends _VariousParametersViewModel {
  const _$_VariousParametersViewModel({
    this.defaultParameter = 'defaultValue',
    required this.requiredParameter,
    this.nullableParameter,
    this.customClass = const CustomClass('custom'),
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final String defaultParameter;
  @override
  final int requiredParameter;
  @override
  final bool? nullableParameter;
  @override
  final CustomClass customClass;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        defaultParameter,
        requiredParameter,
        nullableParameter,
        customClass,
      ];

  @override
  Type get runtimeType => VariousParametersViewModel;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _VariousParametersViewModel extends VariousParametersViewModel {
  const factory _VariousParametersViewModel({
    String defaultParameter,
    required int requiredParameter,
    bool? nullableParameter,
    CustomClass customClass,
  }) = _$_VariousParametersViewModel;

  const _VariousParametersViewModel._() : super._();

  @override
  String get defaultParameter;

  @override
  int get requiredParameter;

  @override
  bool? get nullableParameter;

  @override
  CustomClass get customClass;
}
