import 'package:simple_framework/simple_framework.dart';

import 'models/counter_entity.dart';
import 'models/counter_view_model.dart';

class CounterBuilder extends ModelBuilder<CounterViewModel> {
  @override
  Future<CounterViewModel> build(ref) async {
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
}