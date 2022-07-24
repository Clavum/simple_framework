import 'package:simple_framework/simple_framework.dart';

part 'basic.model.dart';

@generateEntity
class BasicEntity extends Entity with _$BasicEntity {
  const BasicEntity._();

  const factory BasicEntity({
    @Default(0) int value,
  }) = _BasicEntity;
}

@generateViewModel
class BasicViewModel extends ViewModel with _$BasicViewModel {
  const BasicViewModel._();

  const factory BasicViewModel({
    required int value,
  }) = _BasicViewModel;
}
