import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

@immutable
class Entity extends Model {
  const Entity();

  @override
  Entity merge() {
    return const Entity();
  }

  void send() => Repository().sendEntity(this);
}
