import 'package:simple_framework/simple_framework.dart';

part 'custom_methods.model.dart';

@generateEntity
class CustomMethodsEntity extends Entity with _$CustomMethodsEntity {
  const CustomMethodsEntity._();

  const factory CustomMethodsEntity({
    @Default(0) int value,
  }) = _CustomMethodsEntity;

  int someMethod(int input) {
    return value + input;
  }
}

@generateViewModel
class CustomMethodsViewModel extends ViewModel with _$CustomMethodsViewModel {
  const CustomMethodsViewModel._();

  const factory CustomMethodsViewModel({
    @Default(0) int value,
  }) = _CustomMethodsViewModel;

  int someMethod(int input) {
    return value + input;
  }
}
