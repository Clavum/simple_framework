import 'package:simple_framework/simple_framework.dart';

part 'empty.model.dart';

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
