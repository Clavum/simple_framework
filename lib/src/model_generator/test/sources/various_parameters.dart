import 'package:simple_framework/simple_framework.dart';

part 'various_parameters.model.dart';

class CustomClass {
  final String value;

  const CustomClass(this.value);
}

@generateEntity
class VariousParametersEntity extends Entity with _$VariousParametersEntity {
  const VariousParametersEntity._();

  const factory VariousParametersEntity({
    @Default('defaultValue') String defaultParameter,
    // Entities can't have required parameters.
    bool? nullableParameter,
    @Default(CustomClass('custom')) CustomClass customClass,
  }) = _VariousParametersEntity;
}

@generateViewModel
class VariousParametersViewModel extends ViewModel with _$VariousParametersViewModel {
  const VariousParametersViewModel._();

  const factory VariousParametersViewModel({
    @Default('defaultValue') String defaultParameter,
    required int requiredParameter,
    bool? nullableParameter,
    @Default(CustomClass('custom')) CustomClass customClass,
  }) = _VariousParametersViewModel;
}
