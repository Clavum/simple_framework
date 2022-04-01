import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final entityPipe = Pipe<E>();

  final E defaultEntity;

  E get entity => Repository().get(defaultEntity);

  Bloc(this.defaultEntity) {
    Repository().setEntityPipe<E>(entityPipe);
  }

  void dispose() {
    entityPipe.dispose();
  }
}
