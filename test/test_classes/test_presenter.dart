import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

import 'test_bloc.dart';
import 'test_view_model.dart';

class TestPresenter extends Presenter<TestBloc, TestViewModel> {
  @override
  TestBloc createBloc() => TestBloc();

  @override
  Widget build(context, bloc, viewModel) {
    return Text(viewModel.value);
  }

  @override
  Widget buildLoadingWidget(BuildContext context, TestBloc bloc) {
    return const Text('Loading Widget');
  }
}
