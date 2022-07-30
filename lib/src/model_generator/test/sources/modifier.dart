import 'package:simple_framework/simple_framework.dart';

import 'basic.dart';

part 'modifier.model.dart';

@generateEntity
class ModifierEntity extends Entity with _$ModifierEntity {
  const ModifierEntity._();

  const factory ModifierEntity({
    @Default(0) int intValue,
    @Default([]) List<int> listValue,
    @Default({}) Map<String, int> mapValue,
    @Default({}) Set<int> setValue,
    @Default(BasicEntity()) BasicEntity basicEntity,
  }) = _ModifierEntity;
}

// This is here to make sure there are no errors when a ViewModel is generated with a List.
@generateViewModel
class ModifierViewModel extends ViewModel with _$ModifierViewModel {
  const ModifierViewModel._();

  const factory ModifierViewModel({
    required List<int> listValue,
  }) = _ModifierViewModel;
}
