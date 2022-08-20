import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

import 'test_bloc.dart';
import 'test_view_model.dart';

class TestScreen extends Screen<TestBloc, TestViewModel> {
  @override
  TestBloc createBloc() => TestBloc();

  @override
  Widget build(context, bloc, viewModel) {
    return Text(viewModel.value);
  }

  @override
  Widget buildLoadingScreen(BuildContext context, TestBloc bloc) {
    return const Text('Loading Screen');
  }
}
