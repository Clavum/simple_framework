import 'package:simple_framework/simple_framework.dart';

abstract class ModelBuilder<M extends Model> {
  Future<M> build(ScreenRef ref);
}