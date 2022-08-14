import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/test_bloc.dart';
import '../../test_classes/test_view_model.dart';

class _SimpleScreen extends Screen<TestBloc, TestViewModel> {
  const _SimpleScreen(TestBloc testBloc) : super(testBloc);

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

class TestBlocMock extends Mock implements TestBloc {
  TestBlocMock(Stream<TestViewModel> stream) {
    when(() => viewModelStream).thenAnswer((_) => stream);
  }
}

void main() {
  screenTestGroup('Screen', () {
    late TestBlocMock testBlocMock;
    final StreamController<TestViewModel> viewModelStreamController =
        StreamController<TestViewModel>.broadcast(sync: true);

    setUp(() {
      testBlocMock = TestBlocMock(viewModelStreamController.stream);
    });

    Future<void> pumpTestScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: _SimpleScreen(testBlocMock)));
    }

    testWidgets('basic test', (tester) async {
      await pumpTestScreen(tester);
      await tester.pumpAndSettle();

      expect(find.text('Loading Screen'), findsOneWidget);

      viewModelStreamController.add(const TestViewModel(value: '5'));
      await tester.pumpAndSettle();

      expect(find.text('Loaded'), findsOneWidget);
      expect(find.text('Value: 5'), findsOneWidget);

      viewModelStreamController.add(const TestViewModel(value: '6'));
      await tester.pumpAndSettle();
      expect(find.text('Value: 6'), findsOneWidget);

      viewModelStreamController.addError(Error());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('errorFromStream')), findsOneWidget);
    });
  });
}
