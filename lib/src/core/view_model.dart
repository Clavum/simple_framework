import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ViewModel extends Equatable {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}