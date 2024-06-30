// ignore_for_file: type=lint
// coverage:ignore-file

part of 'modifier.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _modifierEntityBypassError = UnsupportedError(
  "ModifierEntity's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$ModifierEntity {
  int get intValue => throw _modifierEntityBypassError;

  List<int> get listValue => throw _modifierEntityBypassError;

  Map<String, int> get mapValue => throw _modifierEntityBypassError;

  Set<int> get setValue => throw _modifierEntityBypassError;

  Map<String, int> get secondMap => throw _modifierEntityBypassError;

  BasicEntity get basicEntity => throw _modifierEntityBypassError;

  List<int>? get defaultNullList => throw _modifierEntityBypassError;

  Map<String, int>? get defaultNullMap => throw _modifierEntityBypassError;

  Set<int>? get defaultNullSet => throw _modifierEntityBypassError;

  set intValue(int intValue) => throw _modifierEntityBypassError;

  set listValue(List<int> listValue) => throw _modifierEntityBypassError;

  set mapValue(Map<String, int> mapValue) => throw _modifierEntityBypassError;

  set setValue(Set<int> setValue) => throw _modifierEntityBypassError;

  set secondMap(Map<String, int> secondMap) => throw _modifierEntityBypassError;

  set basicEntity(BasicEntity basicEntity) => throw _modifierEntityBypassError;

  set defaultNullList(List<int>? defaultNullList) => throw _modifierEntityBypassError;

  set defaultNullMap(Map<String, int>? defaultNullMap) => throw _modifierEntityBypassError;

  set defaultNullSet(Set<int>? defaultNullSet) => throw _modifierEntityBypassError;

  ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
    List<int>? defaultNullList,
    Map<String, int>? defaultNullMap,
    Set<int>? defaultNullSet,
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
  static const List<int>? $defaultNullListDefaultValue = null;
  static const Map<String, int>? $defaultNullMapDefaultValue = null;
  static const Set<int>? $defaultNullSetDefaultValue = null;

  const _$_ModifierEntity({
    this.intValue = 0,
    this.listValue = $listValueDefaultValue,
    this.mapValue = $mapValueDefaultValue,
    this.setValue = $setValueDefaultValue,
    this.secondMap = $secondMapDefaultValue,
    this.basicEntity = const BasicEntity(),
    this.defaultNullList,
    this.defaultNullMap,
    this.defaultNullSet,
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
  final List<int>? defaultNullList;
  @override
  final Map<String, int>? defaultNullMap;
  @override
  final Set<int>? defaultNullSet;

  @override
  List<Object?> get props => [
        intValue,
        listValue,
        mapValue,
        setValue,
        secondMap,
        basicEntity,
        defaultNullList,
        defaultNullMap,
        defaultNullSet,
      ];

  @override
  _ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
    List<int>? defaultNullList,
    Map<String, int>? defaultNullMap,
    Set<int>? defaultNullSet,
  }) {
    return _ModifierEntity(
      intValue: intValue ?? this.intValue,
      listValue: listValue ?? this.listValue,
      mapValue: mapValue ?? this.mapValue,
      setValue: setValue ?? this.setValue,
      secondMap: secondMap ?? this.secondMap,
      basicEntity: basicEntity ?? this.basicEntity,
      defaultNullList: defaultNullList ?? this.defaultNullList,
      defaultNullMap: defaultNullMap ?? this.defaultNullMap,
      defaultNullSet: defaultNullSet ?? this.defaultNullSet,
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
    List<int>? defaultNullList,
    Map<String, int>? defaultNullMap,
    Set<int>? defaultNullSet,
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

  @override
  List<int>? get defaultNullList;

  @override
  Map<String, int>? get defaultNullMap;

  @override
  Set<int>? get defaultNullSet;
}

/// Looking for your model's code? You can go-to-source of this: [ModifierEntity].
$ModifierEntityModifier get modifierEntity => $ModifierEntityModifier();

set modifierEntity(ModifierEntity model) => Repository().set(model);

/// @nodoc
class $ModifierEntityModifier extends _$_ModifierEntity {
  final ModifierEntity Function()? _getOverride;
  final void Function(ModifierEntity)? _setOverride;
  final void Function(bool)? _sendOverride;

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
  void send({bool silent = false}) => (_sendOverride != null)
      ? _sendOverride!.call(silent)
      : Repository().sendModel(_get, silent: silent);

  @override
  int get intValue => _get.intValue;

  @override
  set intValue(int intValue) => _set(_get.merge(intValue: intValue));

  @override
  List<int> get listValue {
    final value = _get.listValue;
    return (value == _$_ModifierEntity.$listValueDefaultValue && value != null)
        ? listValue = List.from(value)
        : value;
  }

  @override
  set listValue(List<int> listValue) => _set(_get.merge(listValue: listValue));

  @override
  Map<String, int> get mapValue {
    final value = _get.mapValue;
    return (value == _$_ModifierEntity.$mapValueDefaultValue && value != null)
        ? mapValue = Map.from(value)
        : value;
  }

  @override
  set mapValue(Map<String, int> mapValue) => _set(_get.merge(mapValue: mapValue));

  @override
  Set<int> get setValue {
    final value = _get.setValue;
    return (value == _$_ModifierEntity.$setValueDefaultValue && value != null)
        ? setValue = Set.from(value)
        : value;
  }

  @override
  set setValue(Set<int> setValue) => _set(_get.merge(setValue: setValue));

  @override
  Map<String, int> get secondMap {
    final value = _get.secondMap;
    return (value == _$_ModifierEntity.$secondMapDefaultValue && value != null)
        ? secondMap = Map.from(value)
        : value;
  }

  @override
  set secondMap(Map<String, int> secondMap) => _set(_get.merge(secondMap: secondMap));

  @override
  $BasicEntityModifier get basicEntity => $BasicEntityModifier(
        () => _get.basicEntity,
        (BasicEntity basicEntity) => this.basicEntity = basicEntity,
        (silent) => send(silent: silent),
      );

  @override
  set basicEntity(BasicEntity basicEntity) => _set(_get.merge(basicEntity: basicEntity));

  @override
  List<int>? get defaultNullList {
    final value = _get.defaultNullList;
    return (value == _$_ModifierEntity.$defaultNullListDefaultValue && value != null)
        ? defaultNullList = List.from(value)
        : value;
  }

  @override
  set defaultNullList(List<int>? defaultNullList) =>
      _set(_get.merge(defaultNullList: defaultNullList));

  @override
  Map<String, int>? get defaultNullMap {
    final value = _get.defaultNullMap;
    return (value == _$_ModifierEntity.$defaultNullMapDefaultValue && value != null)
        ? defaultNullMap = Map.from(value)
        : value;
  }

  @override
  set defaultNullMap(Map<String, int>? defaultNullMap) =>
      _set(_get.merge(defaultNullMap: defaultNullMap));

  @override
  Set<int>? get defaultNullSet {
    final value = _get.defaultNullSet;
    return (value == _$_ModifierEntity.$defaultNullSetDefaultValue && value != null)
        ? defaultNullSet = Set.from(value)
        : value;
  }

  @override
  set defaultNullSet(Set<int>? defaultNullSet) => _set(_get.merge(defaultNullSet: defaultNullSet));

  @override
  _ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    Map<String, int>? secondMap,
    BasicEntity? basicEntity,
    List<int>? defaultNullList,
    Map<String, int>? defaultNullMap,
    Set<int>? defaultNullSet,
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
    if (defaultNullList != null) {
      this.defaultNullList = defaultNullList;
    }
    if (defaultNullMap != null) {
      this.defaultNullMap = defaultNullMap;
    }
    if (defaultNullSet != null) {
      this.defaultNullSet = defaultNullSet;
    }
    return this;
  }
}
