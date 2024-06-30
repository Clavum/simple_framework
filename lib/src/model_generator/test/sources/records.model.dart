// ignore_for_file: type=lint
// coverage:ignore-file

part of 'records.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

final _recordsModelBypassError = UnsupportedError(
  "RecordsModel's constructor was bypassed by another constructor.",
);

/// @nodoc
mixin _$RecordsModel {
  (int, String, double) get record => throw _recordsModelBypassError;

  static const _sentinel = Object();

  RecordsModel merge({
    (int, String, double)? record,
  }) {
    throw _recordsModelBypassError;
  }

  List<Object?> get props => throw _recordsModelBypassError;
}

/// @nodoc
class _$_RecordsModel extends _RecordsModel {
  const _$_RecordsModel({
    required this.record,
  }) : super._();

  @override
  final (int, String, double) record;

  @override
  List<Object?> get props => [
        record,
      ];

  @override
  _RecordsModel merge({
    Object? record = _$RecordsModel._sentinel,
  }) {
    return _RecordsModel(
      record: record == _$RecordsModel._sentinel ? this.record : record as (int, String, double),
    );
  }

  @override
  Type get runtimeType => RecordsModel;
}

/// @nodoc
abstract class _RecordsModel extends RecordsModel {
  const factory _RecordsModel({
    required (int, String, double) record,
  }) = _$_RecordsModel;

  const _RecordsModel._() : super._();

  @override
  (int, String, double) get record;
}
