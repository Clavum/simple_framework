// ignore_for_file: type=lint
// coverage:ignore-file
// dart format off

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

  set defaultParameter(String defaultParameter) => throw _variousParametersEntityBypassError;

  set nullableParameter(bool? nullableParameter) => throw _variousParametersEntityBypassError;

  set customClass(CustomClass customClass) => throw _variousParametersEntityBypassError;

  static const _sentinel = Object();

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
    Object? defaultParameter = _$VariousParametersEntity._sentinel,
    Object? nullableParameter = _$VariousParametersEntity._sentinel,
    Object? customClass = _$VariousParametersEntity._sentinel,
  }) {
    return _VariousParametersEntity(
      defaultParameter: defaultParameter == _$VariousParametersEntity._sentinel
          ? this.defaultParameter
          : defaultParameter as String,
      nullableParameter: nullableParameter == _$VariousParametersEntity._sentinel
          ? this.nullableParameter
          : nullableParameter as bool?,
      customClass: customClass == _$VariousParametersEntity._sentinel
          ? this.customClass
          : customClass as CustomClass,
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

/// Looking for your model's code? You can go-to-source of this: [VariousParametersEntity].
VariousParametersEntity get variousParametersEntity => $VariousParametersEntityModifier();

set variousParametersEntity(VariousParametersEntity model) => Repository().set(model);

/// @nodoc
class $VariousParametersEntityModifier extends _$_VariousParametersEntity {
  final VariousParametersEntity Function()? _getOverride;
  final void Function(VariousParametersEntity)? _setOverride;
  final void Function(bool)? _sendOverride;

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
  void send({bool silent = false}) => (_sendOverride != null)
      ? _sendOverride!.call(silent)
      : Repository().sendModel(_get, silent: silent);

  @override
  String get defaultParameter => _get.defaultParameter;

  @override
  set defaultParameter(String defaultParameter) =>
      _set(_get.merge(defaultParameter: defaultParameter));

  @override
  bool? get nullableParameter => _get.nullableParameter;

  @override
  set nullableParameter(bool? nullableParameter) =>
      _set(_get.merge(nullableParameter: nullableParameter));

  @override
  CustomClass get customClass => _get.customClass;

  @override
  set customClass(CustomClass customClass) => _set(_get.merge(customClass: customClass));

  @override
  _VariousParametersEntity merge({
    Object? defaultParameter = _$VariousParametersEntity._sentinel,
    Object? nullableParameter = _$VariousParametersEntity._sentinel,
    Object? customClass = _$VariousParametersEntity._sentinel,
  }) {
    if (defaultParameter != _$VariousParametersEntity._sentinel) {
      this.defaultParameter = defaultParameter as String;
    }
    if (nullableParameter != _$VariousParametersEntity._sentinel) {
      this.nullableParameter = nullableParameter as bool?;
    }
    if (customClass != _$VariousParametersEntity._sentinel) {
      this.customClass = customClass as CustomClass;
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
