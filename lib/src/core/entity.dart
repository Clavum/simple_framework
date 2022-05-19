import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_framework/simple_framework.dart';

enum EntityState {
  /// Something is working on updating this [Entity].
  loading,

  /// The data in the [Entity] is out of date or invalid for some other reason.
  invalid,

  /// The data was unable to be loaded (such as from service issues).
  error,

  /// The default state.
  active,

  /// If you try to get an [Entity] from the [Repository] which doesn't exist, a new one will be
  /// created, with the state of `fresh`.
  fresh,
}

@immutable
class Entity extends Equatable {
  final EntityState state;

  @override
  bool get stringify => true;

  const Entity({this.state = EntityState.active});

  Entity merge({EntityState? state}) {
    return Entity(state: state ?? this.state);
  }

  void send() => Repository().sendEntity(this);

  @override
  List<Object?> get props => [state];
}
