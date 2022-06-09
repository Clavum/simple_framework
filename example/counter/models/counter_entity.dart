import 'package:simple_framework/simple_framework.dart';

part 'counter_entity.g.dart';

@generateEntity
class CounterEntity extends Entity with _$CounterEntity {
  CounterEntity._();

  factory CounterEntity({
    @Default(0) int counter,
  }) = _CounterEntity;
}
