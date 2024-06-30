import 'package:simple_framework/simple_framework.dart';

import 'basic.dart';

part 'modifier.model.dart';

@generateEntity
class ModifierEntity extends Entity with _$ModifierEntity {
  const ModifierEntity._();

  const factory ModifierEntity({
    @Default(0) int intValue,
    int? nullableIntValue,
    @Default([]) List<int> listValue,
    @Default({}) Map<String, int> mapValue,
    @Default({}) Set<int> setValue,
    @Default({}) Map<String, int> secondMap,
    @Default(BasicEntity()) BasicEntity basicEntity,
    List<int>? defaultNullList,
    Map<String, int>? defaultNullMap,
    Set<int>? defaultNullSet,
  }) = _ModifierEntity;
}
