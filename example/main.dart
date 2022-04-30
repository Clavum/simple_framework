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

class CounterScreen extends Screen<CounterBloc> {
  final String title;

  CounterScreen({required this.title}) : super(CounterBloc());

  @override
  Widget build(context, bloc, ref) {
    CounterEntity counterEntity = ref.getEntity(const CounterEntity());

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
              '${counterEntity.counter}', // Display the "counter" field of the CounterEntity
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

class CounterBloc extends Bloc<CounterEntity> {
  CounterBloc() : super(const CounterEntity());

  void incrementCounter() {
    // "entity" - fetch the current CounterEntity in the Repository
    // ".merge" - Entities are immutable, so use merge to update it
    // "counter: entity.counter + 1" - Increase the counter by one more than what it currently is
    // ".send()" - Send the new Entity to the Screen (also updates Repository)
    entity.merge(counter: entity.counter + 1).send();
  }
}

class CounterEntity extends Entity {
  final int counter;

  const CounterEntity({
    List<EntityFailure> errors = const [],
    this.counter = 0,
  }) : super(errors: errors);

  @override
  List<Object> get props => [errors, counter];

  @override
  CounterEntity merge({errors, int? counter}) {
    return CounterEntity(
      errors: errors ?? this.errors,
      counter: counter ?? this.counter,
    );
  }
}
