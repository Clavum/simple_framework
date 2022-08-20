import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpLoadingScreen(Screen screen) async {
    await pumpWidget(TestWidgetWrapper(
      child: screen.buildLoadingScreen(BuildContextMock(), getBloc(screen)),
    ));
  }

  Future<void> pumpScreen(Screen screen, ViewModel viewModel) async {
    //TODO: catch TypeError and rethrow exception with more helpful info, if viewModel incompatible.
    await pumpWidget(TestWidgetWrapper(
      child: screen.build(BuildContextMock(), getBloc(screen), viewModel),
    ));
  }

  B getBloc<B extends Bloc<V>, V extends ViewModel>(Screen<B, V> screen) {
    return ((screen as StatefulElement).state as ScreenState<B, V>).bloc;
  }
}
