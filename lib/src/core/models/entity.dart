import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

@immutable
abstract class Entity extends Model with MergingModel, RepositoryModel {
  const Entity();

  void send() => Repository().sendModel(this);
}
