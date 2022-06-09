import 'package:simple_framework/simple_framework.dart';

import 'models/counter_entity.dart';

class CounterBloc extends Bloc {
  void incrementCounter() {
    // "counterEntity"
    //   - fetch the current CounterEntity in the Repository
    // ".merge"
    //   - Entities are immutable, so use merge to update it
    // "counter: counterEntity.counter + 1"
    //   - Increment the counter
    // ".send()"
    //   - Send the new Entity to the Screen (also updates it in the Repository)
    counterEntity.merge(counter: counterEntity.counter + 1).send();
  }
}
