// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'modifier.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _modifierEntityBypassError = UnsupportedError(
  'ModifierEntity\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$ModifierEntity {
  int get intValue => throw _modifierEntityBypassError;

  List<int> get listValue => throw _modifierEntityBypassError;

  Map<String, int> get mapValue => throw _modifierEntityBypassError;

  Set<int> get setValue => throw _modifierEntityBypassError;

  Map<String, int> get secondMap => throw _modifierEntityBypassError;

  BasicEntity get basicEntity => throw _modifierEntityBypassError;

  ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
  }) {
    throw _modifierEntityBypassError;
  }

  List<Object?> get props => throw _modifierEntityBypassError;
}

/// @nodoc
class _$_ModifierEntity extends _ModifierEntity {
  static const List<int> $listValueDefaultValue = [];
  static const Map<String, int> $mapValueDefaultValue = {};
  static const Set<int> $setValueDefaultValue = {};
  static const Map<String, int> $secondMapDefaultValue = {};

  const _$_ModifierEntity({
    this.intValue = 0,
    this.listValue = $listValueDefaultValue,
    this.mapValue = $mapValueDefaultValue,
    this.setValue = $setValueDefaultValue,
    this.secondMap = $secondMapDefaultValue,
    this.basicEntity = const BasicEntity(),
  }) : super._();

  @override
  final int intValue;
  @override
  final List<int> listValue;
  @override
  final Map<String, int> mapValue;
  @override
  final Set<int> setValue;
  @override
  final Map<String, int> secondMap;
  @override
  final BasicEntity basicEntity;

  @override
  List<Object?> get props => [
        intValue,
        listValue,
        mapValue,
        setValue,
        secondMap,
        basicEntity,
      ];

  @override
  _ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
  }) {
    return _ModifierEntity(
      intValue: intValue ?? this.intValue,
      listValue: listValue ?? this.listValue,
      mapValue: mapValue ?? this.mapValue,
      setValue: setValue ?? this.setValue,
      secondMap: secondMap ?? this.secondMap,
      basicEntity: basicEntity ?? this.basicEntity,
    );
  }

  @override
  Type get runtimeType => ModifierEntity;
}

/// @nodoc
abstract class _ModifierEntity extends ModifierEntity {
  const factory _ModifierEntity({
    int intValue,
    List<int> listValue,
    Map<String, int> mapValue,
    Set<int> setValue,
    Map<String, int> secondMap,
    BasicEntity basicEntity,
  }) = _$_ModifierEntity;

  const _ModifierEntity._() : super._();

  @override
  int get intValue;

  @override
  List<int> get listValue;

  @override
  Map<String, int> get mapValue;

  @override
  Set<int> get setValue;

  @override
  Map<String, int> get secondMap;

  @override
  BasicEntity get basicEntity;
}

$ModifierEntityModifier get modifierEntity => $ModifierEntityModifier();

set modifierEntity(ModifierEntity model) => Repository().set(model);

/// @nodoc
class $ModifierEntityModifier extends _$_ModifierEntity {
  final ModifierEntity Function()? _getOverride;
  final void Function(ModifierEntity)? _setOverride;
  final void Function()? _sendOverride;

  const $ModifierEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  ModifierEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const ModifierEntity());

  void _set(ModifierEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send() => (_sendOverride != null) ? _sendOverride!.call() : Repository().sendModel(_get);

  @override
  int get intValue => _get.intValue;

  set intValue(int intValue) => _set(_get.merge(intValue: intValue));

  @override
  List<int> get listValue {
    var value = _get.listValue;
    return (value == _$_ModifierEntity.$listValueDefaultValue)
        ? listValue = List.from(value)
        : value;
  }

  set listValue(List<int> listValue) => _set(_get.merge(listValue: listValue));

  @override
  Map<String, int> get mapValue {
    var value = _get.mapValue;
    return (value == _$_ModifierEntity.$mapValueDefaultValue) ? mapValue = Map.from(value) : value;
  }

  set mapValue(Map<String, int> mapValue) => _set(_get.merge(mapValue: mapValue));

  @override
  Set<int> get setValue {
    var value = _get.setValue;
    return (value == _$_ModifierEntity.$setValueDefaultValue) ? setValue = Set.from(value) : value;
  }

  set setValue(Set<int> setValue) => _set(_get.merge(setValue: setValue));

  @override
  Map<String, int> get secondMap {
    var value = _get.secondMap;
    return (value == _$_ModifierEntity.$secondMapDefaultValue)
        ? secondMap = Map.from(value)
        : value;
  }

  set secondMap(Map<String, int> secondMap) => _set(_get.merge(secondMap: secondMap));

  @override
  $BasicEntityModifier get basicEntity => $BasicEntityModifier(
        () => _get.basicEntity,
        (BasicEntity basicEntity) => this.basicEntity = basicEntity,
        () => send(),
      );

  set basicEntity(BasicEntity basicEntity) => _set(_get.merge(basicEntity: basicEntity));

  @override
  _ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
  }) {
    if (intValue != null) {
      this.intValue = intValue;
    }
    if (listValue != null) {
      this.listValue = listValue;
    }
    if (mapValue != null) {
      this.mapValue = mapValue;
    }
    if (setValue != null) {
      this.setValue = setValue;
    }
    if (secondMap != null) {
      this.secondMap = secondMap;
    }
    if (basicEntity != null) {
      this.basicEntity = basicEntity;
    }
    return this;
  }
}

final _modifierViewModelBypassError = UnsupportedError(
  'ModifierViewModel\'s constructor was bypassed by another constructor.',
);

/// @nodoc
mixin _$ModifierViewModel {
  List<int> get listValue => throw _modifierViewModelBypassError;

  List<Object?> get props => throw _modifierViewModelBypassError;
}

/// @nodoc
class _$_ModifierViewModel extends _ModifierViewModel {
  const _$_ModifierViewModel({
    required this.listValue,
  }) : super._();

  @override
  final List<int> listValue;

  @override
  List<Object?> get props => [
        listValue,
      ];

  @override
  Type get runtimeType => ModifierViewModel;
}

/// @nodoc
abstract class _ModifierViewModel extends ModifierViewModel {
  const factory _ModifierViewModel({
    required List<int> listValue,
  }) = _$_ModifierViewModel;

  const _ModifierViewModel._() : super._();

  @override
  List<int> get listValue;
}
