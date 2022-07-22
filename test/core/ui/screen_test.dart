import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../simple_classes/test_bloc.dart';
import '../../simple_classes/test_entity.dart';
import '../../simple_classes/test_screen.dart';
import '../../simple_classes/test_view_model.dart';

void main() {
  screenTestGroup('Screen', () {
    Future<void> pumpTestScreen(WidgetTester tester) async {
      Repository().addMockModel(const TestEntity());
      await tester.pumpWidget(MaterialApp(home: TestScreen()));
      await tester.pumpAndSettle();
    }

    testWidgets('builds loading screen while waiting for bloc.onCreate', (tester) async {
      TestBlocMock bloc = TestBloc() as TestBlocMock;
      when(() => bloc.onCreate()).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
      });

      await pumpTestScreen(tester);

      expect(find.text('Loading Screen'), findsOneWidget);
      verify(() => TestBloc().onCreate()).called(1);

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Loaded'), findsOneWidget);
    });

    testWidgets('builds from the Builder', (tester) async {
      TestBuilderMock builder = TestBuilder() as TestBuilderMock;
      when(() => builder.build(any()))
          .thenAnswer((_) => Future.value(const TestViewModel(value: '10')));

      await pumpTestScreen(tester);

      expect(find.text('Value: 10'), findsOneWidget);
    });

    testWidgets('builds loading screen while waiting for builder', (tester) async {
      TestBuilderMock builder = TestBuilder() as TestBuilderMock;
      when(() => builder.build(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return const TestViewModel(value: '10');
      });

      await pumpTestScreen(tester);

      expect(find.text('Loading Screen'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Loaded'), findsOneWidget);
    });

    testWidgets('rebuilds on Entity updates', (tester) async {
      MockClassProvider().forceUseRealClass<TestBloc>();
      MockClassProvider().forceUseRealClass<Repository>();

      await pumpTestScreen(tester);
      expect(find.text('Value: 0'), findsOneWidget);

      const TestEntity(value: 2).send();
      await tester.pumpAndSettle();
      expect(find.text('Value: 2'), findsOneWidget);

      const TestEntity(value: 5).send();
      await tester.pumpAndSettle();
      expect(find.text('Value: 5'), findsOneWidget);
    });

    testWidgets('avoids rebuild when builder returns duplicate model', (tester) async {
      MockClassProvider().forceUseRealClass<TestBloc>();
      MockClassProvider().forceUseRealClass<Repository>();

      await pumpTestScreen(tester);
      expect(testEntity.buildCallCount, 1);

      testEntity.merge(value: testEntity.value + 1).send();
      await tester.pumpAndSettle();
      expect(testEntity.buildCallCount, 2);

      // Sending the same model shouldn't rebuild the Screen.
      testEntity.send();
      await tester.pumpAndSettle();
      expect(testEntity.buildCallCount, 2);

      // If the Entity is updated, but it is to a field that the Builder doesn't use, the Screen
      // shouldn't rebuild.
      testEntity.merge(extraneousField: 10).send();
      await tester.pumpAndSettle();
      expect(testEntity.buildCallCount, 2);
    });
  });
}
