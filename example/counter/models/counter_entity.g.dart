// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_entity.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

// ignore_for_file: prefer_const_constructors_in_immutables, unused_element

final _privateConstructorUsedError =
    UnsupportedError('The Model\'s factory constructor was bypassed by a private constructor.');

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _$CounterEntity {
  int get counter => throw _privateConstructorUsedError;

  set counter(int counter) => throw _privateConstructorUsedError;

  _CounterEntity merge({
    int? counter,
  }) {
    throw _privateConstructorUsedError;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _$_CounterEntity extends _CounterEntity {
  _$_CounterEntity({
    this.counter = 0,
  }) : super._();

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  final int counter;

  @override
  set counter(int counter) => Repository().set(merge(counter: counter));

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object> get props => [
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

abstract class _CounterEntity extends CounterEntity {
  factory _CounterEntity({
    int counter,
  }) = _$_CounterEntity;

  _CounterEntity._() : super._();

  @override
  int get counter;
}

CounterEntity get counterEntity => Repository().get(CounterEntity());
