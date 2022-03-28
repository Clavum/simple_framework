import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final entityPipe = Pipe<E>();

  final E defaultEntity;

  late Repository _repository;

  Bloc({required this.defaultEntity, Repository? repository}) {
    _repository = repository ?? Repository();
  }

  void sendEntity() {
    entityPipe.send(_repository.get(defaultEntity));
  }

  void dispose() {
    entityPipe.dispose();
  }

  void action(dynamic Function(E) action) async {
    var entity = _repository.get(defaultEntity);
    await action(entity);
    sendEntity();
  }
}
