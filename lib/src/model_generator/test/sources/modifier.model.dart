// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'modifier.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _modifierEntityBypassError = UnsupportedError(
  'ModifierEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$ModifierEntity {
  int get intValue => throw _modifierEntityBypassError;

  List<int> get listValue => throw _modifierEntityBypassError;

  Map<String, int> get mapValue => throw _modifierEntityBypassError;

  Set<int> get setValue => throw _modifierEntityBypassError;

  BasicEntity get basicEntity => throw _modifierEntityBypassError;

  ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    BasicEntity? basicEntity,
  }) {
    throw _modifierEntityBypassError;
  }

  List<Object?> get props => throw _modifierEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_ModifierEntity extends _ModifierEntity {
  static const List<int> $listValueDefaultValue = const [];
  static const Map<String, int> $mapValueDefaultValue = const {};
  static const Set<int> $setValueDefaultValue = const {};

  const _$_ModifierEntity({
    this.intValue = 0,
    this.listValue = $listValueDefaultValue,
    this.mapValue = $mapValueDefaultValue,
    this.setValue = $setValueDefaultValue,
    this.basicEntity = const BasicEntity(),
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int intValue;
  @override
  final List<int> listValue;
  @override
  final Map<String, int> mapValue;
  @override
  final Set<int> setValue;
  @override
  final BasicEntity basicEntity;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        intValue,
        listValue,
        mapValue,
        setValue,
        basicEntity,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _ModifierEntity merge({
    int? intValue,
    List<int>? listValue,
    Map<String, int>? mapValue,
    Set<int>? setValue,
    BasicEntity? basicEntity,
  }) {
    return _ModifierEntity(
      intValue: intValue ?? this.intValue,
      listValue: listValue ?? this.listValue,
      mapValue: mapValue ?? this.mapValue,
      setValue: setValue ?? this.setValue,
      basicEntity: basicEntity ?? this.basicEntity,
    );
  }

  @override
  Type get runtimeType => ModifierEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _ModifierEntity extends ModifierEntity {
  const factory _ModifierEntity({
    int intValue,
    List<int> listValue,
    Map<String, int> mapValue,
    Set<int> setValue,
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
  BasicEntity get basicEntity;
}

_ModifierEntityModifier get modifierEntity => _ModifierEntityModifier();

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _ModifierEntityModifier {
  ModifierEntity get _model => Repository().get(const ModifierEntity());

  void send() => Repository().sendModel(_model);

  void set(ModifierEntity model) => Repository().set(model);

  ModifierEntity get() => _model;

  int get intValue => _model.intValue;

  set intValue(int intValue) => Repository().set(_model.merge(intValue: intValue));

  List<int> get listValue => _process(_model.listValue);

  set listValue(List<int> listValue) => Repository().set(_model.merge(listValue: listValue));

  Map<String, int> get mapValue => _process(_model.mapValue);

  set mapValue(Map<String, int> mapValue) => Repository().set(_model.merge(mapValue: mapValue));

  Set<int> get setValue => _process(_model.setValue);

  set setValue(Set<int> setValue) => Repository().set(_model.merge(setValue: setValue));

  BasicEntity get basicEntity => _model.basicEntity;

  set basicEntity(BasicEntity basicEntity) =>
      Repository().set(_model.merge(basicEntity: basicEntity));

  E _process<E extends Object>(E object) {
    if (object == _$_ModifierEntity.$listValueDefaultValue) {
      return (listValue = List.from(_$_ModifierEntity.$listValueDefaultValue)) as E;
    }
    if (object == _$_ModifierEntity.$mapValueDefaultValue) {
      return (mapValue = Map.from(_$_ModifierEntity.$mapValueDefaultValue)) as E;
    }
    if (object == _$_ModifierEntity.$setValueDefaultValue) {
      return (setValue = Set.from(_$_ModifierEntity.$setValueDefaultValue)) as E;
    }
    return object;
  }
}

final _modifierViewModelBypassError = UnsupportedError(
  'ModifierViewModel\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$ModifierViewModel {
  List<int> get listValue => throw _modifierViewModelBypassError;

  List<Object?> get props => throw _modifierViewModelBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_ModifierViewModel extends _ModifierViewModel {
  const _$_ModifierViewModel({
    required this.listValue,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final List<int> listValue;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        listValue,
      ];

  @override
  Type get runtimeType => ModifierViewModel;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _ModifierViewModel extends ModifierViewModel {
  const factory _ModifierViewModel({
    required List<int> listValue,
  }) = _$_ModifierViewModel;

  const _ModifierViewModel._() : super._();

  @override
  List<int> get listValue;
}
