import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_bloc.dart';
import '../../test_builder.dart';
import '../../test_entity.dart';
import '../../test_screen.dart';
import '../../test_view_model.dart';

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
      when(() => builder.build(any())).thenAnswer((_) => Future.value(TestViewModel(value: '10')));

      await pumpTestScreen(tester);

      expect(find.text('Value: 10'), findsOneWidget);
    });

    testWidgets('builds loading screen while waiting for builder', (tester) async {
      TestBuilderMock builder = TestBuilder() as TestBuilderMock;
      when(() => builder.build(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return TestViewModel(value: '10');
      });

      await pumpTestScreen(tester);

      expect(find.text('Loading Screen'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Loaded'), findsOneWidget);
    });

    testWidgets('rebuilds on Entity updates', (tester) async {
      MockClassProvider().forceUseRealClass<TestBloc>();
      MockClassProvider().forceUseRealClass<TestBuilder>();
      MockClassProvider().forceUseRealClass<Repository>();

      expect(Repository().hashCode, Repository().hashCode);

      await pumpTestScreen(tester);

      expect(find.text('Value: 0'), findsOneWidget);

      const TestEntity(value: 2).send();
      await tester.pumpAndSettle();

      expect(find.text('Value: 2'), findsOneWidget);

      const TestEntity(value: 5).send();
      await tester.pumpAndSettle();

      expect(find.text('Value: 5'), findsOneWidget);
    });
  });
}
