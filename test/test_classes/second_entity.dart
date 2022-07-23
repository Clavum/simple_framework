import 'package:simple_framework/simple_framework.dart';

class SecondEntity extends Entity {
  final int value;

  const SecondEntity({
    this.value = 0,
  });

  @override
  SecondEntity merge({
    int? value,
  }) {
    return SecondEntity(
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [
        value,
      ];
}

SecondEntity get secondEntity => Repository().get(const SecondEntity());
