import 'package:simple_framework/simple_framework.dart';

part 'counter_view_model.g.dart';

@generateViewModel
class CounterViewModel extends ViewModel with _$CounterViewModel {
  factory CounterViewModel({
    required String counter,
  }) = _CounterViewModel;
}
