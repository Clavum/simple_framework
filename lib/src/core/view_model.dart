import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ViewModel extends Equatable {
  @override
  bool? get stringify => true;
}