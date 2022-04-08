import 'package:simple_framework/simple_framework.dart';

abstract class Bloc<E extends Entity> {
  final E defaultEntity;

  E get entity => Repository().get(defaultEntity);

  Bloc(this.defaultEntity);

  void onCreate() {}

  void dispose() {}
}
