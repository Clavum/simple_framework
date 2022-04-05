import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:simple_framework/simple_framework.dart';

/// After I make my own testWidget, testBloc, testScreen methods:
/// Make a method here called "setMock" or something like that which sets the repository to be
/// mocked instead. This would be called automatically at the start of test methods.

class Repository {
  Repository._();

  static final Repository _repository = Repository._();

  final List<Entity> _entities = [];

  final Map<Type, StreamController> _streams = {};

  factory Repository() {
    return _repository;
  }

  E get<E extends Entity>(E entity) {
    return _entities.firstWhere((entity) => entity.runtimeType == E, orElse: () {
      _entities.add(entity);
      return entity;
    }) as E;
  }

  E set<E extends Entity>(E entity) {
    _entities.retainWhere((element) => element.runtimeType != E);
    _entities.add(entity);
    return entity;
  }

  void sendEntity(entity) {
    _entities.retainWhere((element) => element.runtimeType != entity.runtimeType);
    _entities.add(entity);
    if (_streams.containsKey(entity.runtimeType)) {
      _streams[entity.runtimeType]!.add(entity);
    } else {
      if (kDebugMode) {
        print('There is no Screen subscribed to receive ${entity.runtimeType}');
      }
    }
  }

  Stream streamOf<E extends Entity>() {
    return (_streams[E] = _streams.putIfAbsent(E, () => StreamController<E>.broadcast())).stream;
  }
}
