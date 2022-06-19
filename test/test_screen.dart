import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

import 'test_bloc.dart';
import 'test_builder.dart';
import 'test_view_model.dart';

class TestScreen extends Screen<TestBloc, TestViewModel> {
  TestScreen() : super(TestBloc(), TestBuilder());

  @override
  Widget build(context, bloc, viewModel) {
    return Column(
      children: [
        const Text('Loaded'),
        Text('Value: ${viewModel.value}'),
      ],
    );
  }

  @override
  Widget buildLoadingScreen(BuildContext context, TestBloc bloc) {
    return const Text('Loading Screen');
  }
}
