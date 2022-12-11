part of '../core.dart';

@immutable
abstract class Entity extends Model with MergingModel, RepositoryModel {
  const Entity();

  void send({bool silent = false}) => Repository().sendModel(this, silent: silent);
}
