import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

/// A version of the classic Flutter Counter app, except using the Simple Framework.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Framework Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(title: 'Simple Framework Counter'),
    );
  }
}

class CounterScreen extends Screen<CounterBloc, CounterViewModel> {
  final String title;

  CounterScreen({required this.title}) : super(CounterBloc(), CounterBuilder());

  @override
  Widget build(context, bloc, viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              viewModel.counter, // Display the "counter" field of the CounterViewModel
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.incrementCounter(), // Call bloc method
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterBloc extends Bloc {
  CounterEntity get counterEntity => Repository().get(const CounterEntity());

  void incrementCounter() {
    // "counterEntity" - fetch the current CounterEntity in the Repository
    // ".merge" - Entities are immutable, so use merge to update it
    // "counter: counterEntity.counter + 1" - Increment the counter
    // ".send()" - Send the new Entity to the Screen (also updates the Repository)
    counterEntity.merge(counter: counterEntity.counter + 1).send();
  }
}

class CounterEntity extends Entity {
  final int counter;

  const CounterEntity({
    this.counter = 0,
  });

  @override
  List<Object> get props => [counter];

  @override
  CounterEntity merge({state, int? counter}) {
    return CounterEntity(
      counter: counter ?? this.counter,
    );
  }
}

class CounterViewModel extends ViewModel {
  final String counter;

  CounterViewModel({
    required this.counter,
  });

  @override
  List<Object?> get props => [
        counter,
      ];
}

class CounterBuilder extends ModelBuilder<CounterViewModel> {
  @override
  Future<CounterViewModel> build(ref) async {
    // First, use ref to get the Entity/Entities needed to build the Screen.
    var counterEntity = ref.getEntity(const CounterEntity());

    // Now, the builder is "subscribed" to CounterEntity updates, and this build method will be
    // called on every update. However, the build method of the Screen which uses this builder will
    // only update if the ViewModel is new, sparing resources if a field is updated in the Entity
    // that is used for a different Screen.

    return CounterViewModel(
      counter: '${counterEntity.counter}',
    );
  }
}
