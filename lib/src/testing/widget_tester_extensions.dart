import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpLoadingWidget(Presenter presenter) async {
    await pumpWidget(TestWidgetWrapper(
      child: presenter.buildLoadingWidget(BuildContextMock(), getBloc(presenter)),
    ));
  }

  Future<void> pumpPresenter(Presenter presenter, ViewModel viewModel) async {
    //TODO: catch TypeError and rethrow exception with more helpful info, if viewModel incompatible.
    await pumpWidget(TestWidgetWrapper(
      child: presenter.build(BuildContextMock(), getBloc(presenter), viewModel),
    ));
  }

  B getBloc<B extends Bloc<V>, V extends ViewModel>(Presenter<B, V> presenter) {
    return ((presenter as StatefulElement).state as PresenterState<B, V>).bloc;
  }
}
