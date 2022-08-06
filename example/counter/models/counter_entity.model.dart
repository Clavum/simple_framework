// ignore_for_file: prefer_const_constructors, unused_element
// coverage:ignore-file

part of 'counter_entity.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _counterEntityBypassError = UnsupportedError(
  'CounterEntity\'s constructor was bypassed by another constructor.',
);

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$CounterEntity {
  int get counter => throw _counterEntityBypassError;

  CounterEntity merge({
    int? counter,
  }) {
    throw _counterEntityBypassError;
  }

  List<Object?> get props => throw _counterEntityBypassError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_CounterEntity extends _CounterEntity {
  const _$_CounterEntity({
    this.counter = 0,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int counter;

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        counter,
      ];

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _CounterEntity merge({
    int? counter,
  }) {
    return _CounterEntity(
      counter: counter ?? this.counter,
    );
  }

  @override
  Type get runtimeType => CounterEntity;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _CounterEntity extends CounterEntity {
  const factory _CounterEntity({
    int counter,
  }) = _$_CounterEntity;

  const _CounterEntity._() : super._();

  @override
  int get counter;
}

_CounterEntityModifier get counterEntity => _CounterEntityModifier();

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _CounterEntityModifier {
  CounterEntity get _model => Repository().get(const CounterEntity());

  void send() => Repository().sendModel(_model);

  void set(CounterEntity model) => Repository().set(model);

  CounterEntity get() => _model;

  int get counter => _model.counter;

  set counter(int counter) => Repository().set(_model.merge(counter: counter));
}
