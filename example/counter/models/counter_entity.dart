import 'package:simple_framework/simple_framework.dart';

part 'counter_entity.model.dart';

@generateEntity
class CounterEntity extends Entity with _$CounterEntity {
  const CounterEntity._();

  const factory CounterEntity({
    @Default(0) int counter,
  }) = _CounterEntity;
}
