import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_classes/second_entity.dart';
import '../../test_classes/test_bloc.dart';
import '../../test_classes/test_entity.dart';
import '../../test_classes/test_presenter.dart';
import '../../test_classes/test_view_model.dart';

class TestBlocMock extends Mock implements TestBloc {
  TestBlocMock() {
    registerFallbackValue(const TestViewModel(value: '999'));
    when(buildViewModel).thenAnswer((_) {
      return TestViewModel(value: Repository().get(const TestEntity()).value.toString());
    });
    when(() => shouldSendNewModel(any(), any())).thenReturn(true);
  }
}

void main() {
  group('Presenter', () {
    late TestBlocMock bloc;

    setUp(() {
      setMock(bloc = TestBlocMock());
    });

    tearDown(() {
      Repository().reset();
    });

    testWidgets('initially builds from the Bloc', (tester) async {
      Repository().set(testEntity.merge(value: 5));

      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('rebuilds after Entity updates', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      testEntity.merge(value: 10).send();
      await tester.pumpAndSettle();
      expect(find.text('10'), findsOneWidget);

      testEntity.merge(value: 15).send();
      await tester.pumpAndSettle();
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('works synchronously', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      // If the Entity streams were async, then these two lines of code would run, then the
      // ViewModel would be built afterwards, fetching the latest value of 15, even though that
      // was not the value sent. Instead, the ViewModel is built synchronously, so immediately
      // after the first line, a ViewModel is built with a value of 10, and changing it
      // afterwards doesn't affect it.
      testEntity.merge(value: 10).send();
      Repository().set(testEntity.merge(value: 15));

      await tester.pumpAndSettle();
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('with inconsistent build', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      // Change the buildViewModel method to depend on SecondEntity. This might happen in real
      // code if the buildViewModel method has if conditions which use different entities in each
      // branch.
      when(() => bloc.buildViewModel()).thenAnswer((_) {
        return TestViewModel(value: Repository().get(const SecondEntity()).value.toString());
      });

      // Cause a rebuild, so that buildViewModel will be called again, this time depending on
      // SecondEntity.
      testEntity.merge(value: 10).send();

      // We should now expect updating SecondEntity will trigger a rebuild.
      secondEntity.merge(value: 15).send();
      await tester.pumpAndSettle();
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('custom shouldSendViewModel method', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      when(() => bloc.shouldSendNewModel(any(), any())).thenReturn(false);

      testEntity.merge(value: 10).send();
      await tester.pumpAndSettle();
      expect(find.text('10'), findsNothing);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('builds loading widget until onCreate finishes', (tester) async {
      when(() => bloc.onCreate()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        Repository().set(testEntity.merge(value: 123));
      });

      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      // Can't use pumpAndSettle or onCreate will finish!

      expect(find.text('0'), findsNothing);
      expect(find.text('123'), findsNothing);
      expect(find.text('Loading Widget'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('0'), findsNothing);
      expect(find.text('123'), findsOneWidget);
    });

    testWidgets('when disposed, Repository stream is cancelled', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestPresenter()));
      await tester.pumpAndSettle();

      expect(Repository().hasActiveStream<TestEntity>(), true);

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();

      expect(Repository().hasActiveStream<TestEntity>(), false);
    });
  });
}
