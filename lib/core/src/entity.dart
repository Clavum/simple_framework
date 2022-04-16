import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_framework/simple_framework.dart';

@immutable
class Entity extends Equatable {
  final List<EntityFailure> errors;

  @override
  bool get stringify => true;

  const Entity({this.errors = const []});

  bool hasErrors() => errors.isNotEmpty;

  bool hasError(EntityFailure error) => errors.indexOf(error) > 0;

  Entity merge({List<EntityFailure>? errors}) {
    return Entity(errors: errors ?? this.errors);
  }

  void send() => Repository().sendEntity(this);

  @override
  List<Object?> get props => [errors];
}

class EntityFailure extends Equatable {
  const EntityFailure();

  @override
  List<Object?> get props => [];
}

class GeneralEntityFailure extends EntityFailure {
  const GeneralEntityFailure();
}

class NoConnectivityEntityFailure extends EntityFailure {
  const NoConnectivityEntityFailure();
}
