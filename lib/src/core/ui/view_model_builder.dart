import 'package:simple_framework/simple_framework.dart';

abstract class ViewModelBuilder<V extends ViewModel> {
  Future<V> build(ScreenRef ref);
}