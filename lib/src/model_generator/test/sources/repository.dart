import 'package:simple_framework/simple_framework.dart';

part 'repository.model.dart';

@generateEntity
class RepositoryEntity extends Entity with _$RepositoryEntity {
  const RepositoryEntity._();

  const factory RepositoryEntity({
    @Default(0) int intValue,
    @Default([]) List<int> listValue,
  }) = _RepositoryEntity;
}
