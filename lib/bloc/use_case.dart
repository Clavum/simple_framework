import 'package:simple_framework/entity/entity.dart';

typedef EntityCallback<T extends Entity> = bool Function(T);

abstract class UseCase {}
