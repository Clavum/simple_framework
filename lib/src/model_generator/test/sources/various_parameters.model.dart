// ignore_for_file: prefer_const_constructors, unused_element, sort_constructors_first, library_private_types_in_public_api
// coverage:ignore-file

part of 'various_parameters.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _variousParametersEntityBypassError = UnsupportedError(
  "VariousParametersEntity's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$VariousParametersEntity {
  String get defaultParameter => throw _variousParametersEntityBypassError;

  bool? get nullableParameter => throw _variousParametersEntityBypassError;

  CustomClass get customClass => throw _variousParametersEntityBypassError;

  VariousParametersEntity merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    throw _variousParametersEntityBypassError;
  }

  List<Object?> get props => throw _variousParametersEntityBypassError;
}

/// @nodoc
class _$_VariousParametersEntity extends _VariousParametersEntity {
  const _$_VariousParametersEntity({
    this.defaultParameter = 'defaultValue',
    this.nullableParameter,
    this.customClass = const CustomClass('custom'),
  }) : super._();

  @override
  final String defaultParameter;
  @override
  final bool? nullableParameter;
  @override
  final CustomClass customClass;

  @override
  List<Object?> get props => [
        defaultParameter,
        nullableParameter,
        customClass,
      ];

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

$VariousParametersEntityModifier get variousParametersEntity => $VariousParametersEntityModifier();

set variousParametersEntity(VariousParametersEntity model) => Repository().set(model);

/// @nodoc
class $VariousParametersEntityModifier extends _$_VariousParametersEntity {
  final VariousParametersEntity Function()? _getOverride;
  final void Function(VariousParametersEntity)? _setOverride;
  final void Function()? _sendOverride;

  const $VariousParametersEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  VariousParametersEntity get _get => (_getOverride != null)
      ? _getOverride!.call()
      : Repository().get(const VariousParametersEntity());

  void _set(VariousParametersEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send() => (_sendOverride != null) ? _sendOverride!.call() : Repository().sendModel(_get);

  @override
  String get defaultParameter => _get.defaultParameter;

  set defaultParameter(String defaultParameter) =>
      _set(_get.merge(defaultParameter: defaultParameter));

  @override
  bool? get nullableParameter => _get.nullableParameter;

  set nullableParameter(bool? nullableParameter) =>
      _set(_get.merge(nullableParameter: nullableParameter));

  @override
  CustomClass get customClass => _get.customClass;

  set customClass(CustomClass customClass) => _set(_get.merge(customClass: customClass));

  @override
  _VariousParametersEntity merge({
    String? defaultParameter,
    bool? nullableParameter,
    CustomClass? customClass,
  }) {
    if (defaultParameter != null) {
      this.defaultParameter = defaultParameter;
    }
    if (nullableParameter != null) {
      this.nullableParameter = nullableParameter;
    }
    if (customClass != null) {
      this.customClass = customClass;
    }
    return this;
  }
}

final _variousParametersViewModelBypassError = UnsupportedError(
  "VariousParametersViewModel's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$VariousParametersViewModel {
  String get defaultParameter => throw _variousParametersViewModelBypassError;

  int get requiredParameter => throw _variousParametersViewModelBypassError;

  bool? get nullableParameter => throw _variousParametersViewModelBypassError;

  CustomClass get customClass => throw _variousParametersViewModelBypassError;

  List<Object?> get props => throw _variousParametersViewModelBypassError;
}

/// @nodoc
class _$_VariousParametersViewModel extends _VariousParametersViewModel {
  const _$_VariousParametersViewModel({
    this.defaultParameter = 'defaultValue',
    required this.requiredParameter,
    this.nullableParameter,
    this.customClass = const CustomClass('custom'),
  }) : super._();

  @override
  final String defaultParameter;
  @override
  final int requiredParameter;
  @override
  final bool? nullableParameter;
  @override
  final CustomClass customClass;

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
