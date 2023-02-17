import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

import 'counter_bloc.dart';
import 'models/counter_view_model.dart';

class CounterPresenter extends Presenter<CounterBloc, CounterViewModel> {
  final String title;

  const CounterPresenter({required this.title});

  @override
  CounterBloc createBloc() => CounterBloc();

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
              viewModel.counter,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
