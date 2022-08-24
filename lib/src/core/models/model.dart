import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class Model extends Equatable {
  const Model();

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [];
}

/// Used to ensure only certain Models are put in the Repository.
mixin RepositoryModel on Model {}

mixin MergingModel on Model {
  Model merge() => this;
}
