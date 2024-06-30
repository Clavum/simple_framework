import 'package:simple_framework/simple_framework.dart';

part 'basic.model.dart';

@generateEntity
class BasicEntity extends Entity with _$BasicEntity {
  const BasicEntity._();

  const factory BasicEntity({
    @Default(0) int value,
    int? nullableValue,
  }) = _BasicEntity;
}

@generateViewModel
class BasicViewModel extends ViewModel with _$BasicViewModel {
  const BasicViewModel._();

  const factory BasicViewModel({
    required int value,
  }) = _BasicViewModel;
}

// This is here to make sure there are no errors when a ViewModel is generated with a List.
@generateViewModel
class ModifierViewModel extends ViewModel with _$ModifierViewModel {
  const ModifierViewModel._();

  const factory ModifierViewModel({
    required List<int> listValue,
  }) = _ModifierViewModel;
}
