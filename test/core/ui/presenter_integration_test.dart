import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_view_model.dart';

class InheritedDependencyBloc extends Bloc<TestViewModel> {
  @override
  TestViewModel buildViewModel() {
    final dependency = Directionality.of(context);
    return TestViewModel(value: dependency == TextDirection.ltr ? 'ltr' : 'rtl');
  }
}

class InheritedDependencyPresenter extends Presenter<InheritedDependencyBloc, TestViewModel> {
  @override
  InheritedDependencyBloc createBloc() => InheritedDependencyBloc();

  @override
  Widget build(context, bloc, viewModel) {
    return Text(viewModel.value);
  }
}

// These tests aren't real integration tests, but they don't use mocks and test the Bloc and Presenter
// together, so the name is appropriate.
void main() {
  group('Presenter integration', () {
    testWidgets('updates with inherited widgets', (tester) async {
      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: InheritedDependencyPresenter(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('ltr'), findsOneWidget);

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: InheritedDependencyPresenter(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('rtl'), findsOneWidget);
    });
  });
}
