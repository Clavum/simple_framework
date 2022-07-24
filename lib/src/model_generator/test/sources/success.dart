import 'package:simple_framework/simple_framework.dart';

part 'success.model.dart';

class CustomClass {
  final String value;

  const CustomClass(this.value);
}

@generateEntity
class EntitySuccess extends Entity with _$EntitySuccess {
  const EntitySuccess._();

  const factory EntitySuccess({
    @Default('defaultValue') String defaultParameter,
    bool? nullableParameter,
    @Default(CustomClass('custom')) CustomClass customClass,
  }) = _EntitySuccess;

  String someMethod(int input) {
    return '$defaultParameter$input';
  }
}

@generateViewModel
class ViewModelSuccess extends ViewModel with _$ViewModelSuccess {
  const ViewModelSuccess._();

  const factory ViewModelSuccess({
    @Default('defaultValue') String defaultParameter,
    required int requiredParameter,
    bool? nullableParameter,
  }) = _ViewModelSuccess;

  int someMethod(int input) {
    return requiredParameter + input;
  }
}

@generateEntity
class EmptyEntity extends Entity with _$EmptyEntity {
  const EmptyEntity._();

  const factory EmptyEntity() = _EmptyEntity;
}

@generateViewModel
class EmptyViewModel extends ViewModel with _$EmptyViewModel {
  const EmptyViewModel._();

  const factory EmptyViewModel() = _EmptyViewModel;
}
