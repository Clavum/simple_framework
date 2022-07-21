import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

import 'counter_bloc.dart';
import 'models/counter_view_model.dart';

class CounterScreen extends Screen<CounterBloc, CounterViewModel> {
  final String title;

  CounterScreen({required this.title}) : super(CounterBloc());

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
