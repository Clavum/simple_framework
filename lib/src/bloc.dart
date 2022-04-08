import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final E defaultEntity;

  final List<StreamSubscription<void>> _entitySubscriptions = [];

  Bloc(this.defaultEntity);

  E get entity => Repository().get(defaultEntity);

  void synchronizeWithRepo<T extends Entity>(T initialEntity, Entity Function(T) entityCreator) {
    Repository().set(entityCreator(Repository().get(initialEntity)));
    _entitySubscriptions.add(
      Repository().streamOf<T>().listen((balanceEntity) {
        entityCreator(Repository().get(balanceEntity)).send();
      }),
    );
  }

  void onCreate() {}

  @mustCallSuper
  void dispose() {
    for (var subscription in _entitySubscriptions) {
      subscription.cancel();
    }
  }
}
