import 'dart:async';

import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final StreamController<E> entityStream = StreamController<E>.broadcast();

  final E defaultEntity;

  E get entity => Repository().get(defaultEntity);

  Bloc(this.defaultEntity) {
    Repository().setEntityStream<E>(entityStream);
  }

  void dispose() {
    entityStream.close();
  }
}
