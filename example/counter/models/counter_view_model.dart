import 'package:simple_framework/simple_framework.dart';

part 'counter_view_model.model.dart';

@generateViewModel
class CounterViewModel extends ViewModel with _$CounterViewModel {
  const CounterViewModel._();

  const factory CounterViewModel({
    required String counter,
  }) = _CounterViewModel;
}
