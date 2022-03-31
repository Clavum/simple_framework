import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final entityPipe = Pipe<E>();

  final E defaultEntity;

  E get entity => Repository().get(defaultEntity);

  Bloc(this.defaultEntity) {
    Repository().setEntityPipe<E>(entityPipe);
  }

  /// Used by the Presenter's initial entity request. This needs to be here because the default
  /// entity is needed.
  void sendEntity() {
    entityPipe.send(Repository().get(defaultEntity));
  }

  void dispose() {
    entityPipe.dispose();
  }
}
