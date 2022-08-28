// ignore_for_file: prefer_const_constructors, unused_element, sort_constructors_first, library_private_types_in_public_api
// coverage:ignore-file

part of 'counter_view_model.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _counterViewModelBypassError = UnsupportedError(
  "CounterViewModel's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$CounterViewModel {
  String get counter => throw _counterViewModelBypassError;

  List<Object?> get props => throw _counterViewModelBypassError;
}

/// @nodoc
class _$_CounterViewModel extends _CounterViewModel {
  const _$_CounterViewModel({
    required this.counter,
  }) : super._();

  @override
  final String counter;

  @override
  List<Object?> get props => [
        counter,
      ];

  @override
  Type get runtimeType => CounterViewModel;
}

/// @nodoc
abstract class _CounterViewModel extends CounterViewModel {
  const factory _CounterViewModel({
    required String counter,
  }) = _$_CounterViewModel;

  const _CounterViewModel._() : super._();

  @override
  String get counter;
}
