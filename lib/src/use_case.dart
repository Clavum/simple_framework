import 'package:simple_framework/simple_framework.dart';

typedef EntityCallback<T extends Entity> = bool Function(T);

abstract class UseCase {}
