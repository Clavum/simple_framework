// ignore_for_file: prefer_const_constructors, unused_element, sort_constructors_first, library_private_types_in_public_api
// coverage:ignore-file

part of 'counter_entity.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _counterEntityBypassError = UnsupportedError(
  "CounterEntity's constructor was bypassed by another constructor.",
);

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

/// @nodoc
class _$_CounterEntity extends _CounterEntity {
  const _$_CounterEntity({
    this.counter = 0,
  }) : super._();

  @override
  final int counter;

  @override
  List<Object?> get props => [
        counter,
      ];

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

/// @nodoc
abstract class _CounterEntity extends CounterEntity {
  const factory _CounterEntity({
    int counter,
  }) = _$_CounterEntity;

  const _CounterEntity._() : super._();

  @override
  int get counter;
}

$CounterEntityModifier get counterEntity => $CounterEntityModifier();

set counterEntity(CounterEntity model) => Repository().set(model);

/// @nodoc
class $CounterEntityModifier extends _$_CounterEntity {
  final CounterEntity Function()? _getOverride;
  final void Function(CounterEntity)? _setOverride;
  final void Function()? _sendOverride;

  const $CounterEntityModifier([
    this._getOverride,
    this._setOverride,
    this._sendOverride,
  ]);

  CounterEntity get _get =>
      (_getOverride != null) ? _getOverride!.call() : Repository().get(const CounterEntity());

  void _set(CounterEntity model) =>
      (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

  @override
  void send() => (_sendOverride != null) ? _sendOverride!.call() : Repository().sendModel(_get);

  @override
  int get counter => _get.counter;

  set counter(int counter) => _set(_get.merge(counter: counter));

  @override
  _CounterEntity merge({
    int? counter,
  }) {
    if (counter != null) {
      this.counter = counter;
    }
    return this;
  }
}
