import 'package:flutter/material.dart';

import 'counter/counter_presenter.dart';

/// A version of the classic Flutter Counter app, using the Simple Framework.

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
      home: const CounterPresenter(title: 'Simple Framework Counter'),
    );
  }
}
