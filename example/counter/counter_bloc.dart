import 'package:simple_framework/simple_framework.dart';

import 'models/counter_entity.dart';
import 'models/counter_view_model.dart';

class CounterBloc extends Bloc<CounterViewModel> {
  @override
  CounterViewModel buildViewModel() {
    return CounterViewModel(counter: counterEntity.counter.toString());
  }

  void incrementCounter() {
    counterEntity.counter++;
    counterEntity.send();
  }
}
