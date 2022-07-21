import 'package:simple_framework/simple_framework.dart';

import 'models/counter_entity.dart';
import 'models/counter_view_model.dart';

class CounterBloc extends Bloc<CounterViewModel> {
  // This method in the Bloc gives any Screen which uses it a way to get ViewModels.
  @override
  Future<CounterViewModel> buildViewModel(ref) async {
    // First, use ref to get the Entity/Entities needed to build the Screen.
    var counterEntity = ref.getEntity(CounterEntity());

    // Now, the builder is "subscribed" to CounterEntity updates, and this build method will be
    // called on every update. However, the build method of the Screen which uses this builder will
    // only update if the ViewModel is new, sparing resources if a field is updated in the Entity
    // that is used for a different Screen.

    return CounterViewModel(
      counter: '${counterEntity.counter}',
    );
  }

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
