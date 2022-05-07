import 'package:simple_framework/simple_framework.dart';

abstract class ViewModelBuilder<V extends ViewModel> {
  V build(EntityRef ref);
}