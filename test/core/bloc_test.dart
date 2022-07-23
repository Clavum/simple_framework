import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';

import '../test_classes//test_entity.dart';
import '../test_classes/second_entity.dart';
import '../test_classes/test_view_model.dart';

class _SimpleBloc extends Bloc<TestViewModel> {
  @override
  TestViewModel buildViewModel() => TestViewModel(value: testEntity.value.toString());

  @override
  void onCreate() {
    Repository().set(testEntity.merge(buildCallCount: testEntity.buildCallCount + 1));
  }
}

class _ToggleBuildBloc extends Bloc<TestViewModel> {
  bool _buildCalled = false;

  @override
  TestViewModel buildViewModel() {
    if (!_buildCalled) {
      _buildCalled = true;
      return TestViewModel(value: testEntity.value.toString());
    } else {
      return TestViewModel(value: secondEntity.value.toString());
    }
  }
}

class _BuildUnderTenBloc extends Bloc<TestViewModel> {
  @override
  TestViewModel buildViewModel() => TestViewModel(value: testEntity.value.toString());

  @override
  bool shouldSendNewModel(TestViewModel? oldViewModel, TestViewModel newViewModel) {
    return newViewModel.value.length < 10;
  }
}

class _CreateDelayBloc extends Bloc<TestViewModel> {
  @override
  TestViewModel buildViewModel() => TestViewModel(value: testEntity.value.toString());

  @override
  Future<void> onCreate() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Repository().set(testEntity.merge(value: 123));
  }
}

void main() {
  group('Bloc', () {
    late _SimpleBloc simpleBloc;
    late _ToggleBuildBloc toggleBuildBloc;
    late _BuildUnderTenBloc buildUnderTenBloc;
    late _CreateDelayBloc createDelayBloc;

    setUp(() {
      Repository().set(const TestEntity(value: 5));
      Repository().set(const SecondEntity(value: 10));
      simpleBloc = _SimpleBloc();
      toggleBuildBloc = _ToggleBuildBloc();
      buildUnderTenBloc = _BuildUnderTenBloc();
      createDelayBloc = _CreateDelayBloc();
    });

    tearDown(() {
      simpleBloc.dispose();
      toggleBuildBloc.dispose();
      buildUnderTenBloc.dispose();
      createDelayBloc.dispose();
    });

    /// Listening to the stream should trigger an initial ViewModel to be built.
    test('builds initial ViewModel from Repository', () {
      late final StreamSubscription subscription;
      subscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        expect(viewModel.value, '5');
        subscription.cancel();
      }));
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// When the _SimpleBloc builds from the TestEntity, it should recognize this dependency and
    /// send a new ViewModel when the TestEntity changes.
    test('rebuilds after Entity updates', () async {
      int callCount = 0;
      late final StreamSubscription subscription;
      subscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (callCount == 0) {
          expect(viewModel.value, '5');
          testEntity.merge(value: 10).send();
        } else if (callCount == 1) {
          expect(viewModel.value, '10');
          testEntity.merge(value: 15).send();
        } else {
          expect(viewModel.value, '15');
          subscription.cancel();
        }
        callCount++;
      }, count: 3));
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// See the comment in the test for an explanation.
    test('works synchronously', () async {
      int callCount = 0;
      late final StreamSubscription subscription;
      subscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (callCount == 0) {
          expect(viewModel.value, '5');

          // If the Entity streams were async, then these two lines of code would run, then the
          // ViewModel would be built afterwards, fetching the latest value of 15, even though that
          // was not the value sent. Instead, the ViewModel is built synchronously, so immediately
          // after the first line, a ViewModel is built with a value of 10, and changing it
          // afterwards doesn't affect it.
          testEntity.merge(value: 10).send();
          Repository().set(testEntity.merge(value: 15));
        } else {
          expect(viewModel.value, '10');
          subscription.cancel();
        }
        callCount++;
      }, count: 2));
      await Future.delayed(Duration.zero);
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// The _ToggleBuildBloc has a buildViewModel method which doesn't always depend on the same
    /// Entity to build. It uses testEntity for the first build, and secondEntity afterwards. The
    /// Bloc should rebuild from updates to either (only after they are used, of course, there's
    /// no way to know it depends on secondEntity until the second build).
    /// This scenario should ideally never happen in real code, but it can still be tested anyway.
    test('with inconsistent build', () {
      late final StreamSubscription subscription;
      int callCount = 0;
      subscription = toggleBuildBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (callCount == 0) {
          expect(viewModel.value, '5');
          testEntity.merge(value: 6).send(); // Triggers a rebuild, but secondEntity will be used.
        } else if (callCount == 1) {
          expect(viewModel.value, '10');
          secondEntity.merge(value: 15).send();
        } else {
          expect(viewModel.value, '15');
          subscription.cancel();
        }
        callCount++;
      }, count: 3));
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// Unless overridden, the shouldSendNewModel method prevents sending duplicates.
    test('avoids duplicate ViewModels by default', () {
      late final StreamSubscription subscription;
      int callCount = 0;
      subscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (callCount == 0) {
          expect(viewModel.value, '5');
          testEntity.merge(value: 5).send(); // Ignored as a duplicate
          testEntity.merge(value: 10).send(); // Triggers a rebuild.
        } else if (callCount == 1) {
          expect(viewModel.value, '10');
          testEntity.merge(value: 10).send(); // Ignored as a duplicate
          subscription.cancel();
        }
        callCount++;
      }, count: 2));
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// The _BuildUnderTenBloc overrides shouldSendNewModel to prevent sending any ViewModel with
    /// a value under 10. This test ensures this override works as expected.
    test('custom shouldSendViewModel method', () {
      late final StreamSubscription subscription;
      int callCount = 0;
      subscription = buildUnderTenBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (callCount == 0) {
          expect(viewModel.value, '5');
          testEntity.merge(value: 9).send(); // Triggers a rebuild.
        } else if (callCount == 1) {
          expect(viewModel.value, '9');
          testEntity.merge(value: 10).send(); // Ignored; over ten.
          testEntity.merge(value: 11).send(); // Ignored; over ten.
          subscription.cancel();
        }
        callCount++;
      }, count: 2));
    }, timeout: const Timeout(Duration(seconds: 3)));

    /// The _CreateDelayBloc overrides onCreate to wait 10 milliseconds, then sets testEntity's
    /// value to 123. We should expect that we never get a ViewModel with value 5, the default,
    /// but instead wait for onCreate to finish, and then get a ViewModel with a value of 123.
    test('waits for onCreate', () {
      late final StreamSubscription subscription;
      subscription = createDelayBloc.viewModelStream.listen(expectAsync1((viewModel) {
        expect(viewModel.value, '123');
        subscription.cancel();
      }));
    });

    /// It is possible to have two or more Screens depending on the same Bloc. In this case, we
    /// expect that:
    ///   1) Both Screens get an initial ViewModel
    ///   2) The Bloc's onCreate method is called only once
    ///   3) Both Screens receive the ViewModel whenever it is sent
    test('with multiple listeners', () async {
      late final StreamSubscription firstSubscription;
      int firstCallCount = 0;
      firstSubscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (firstCallCount == 0) {
          expect(viewModel.value, '5');
        } else if (firstCallCount == 1) {
          expect(viewModel.value, '10');
          firstSubscription.cancel();
        }
        firstCallCount++;
      }, count: 2));

      late final StreamSubscription secondSubscription;
      int secondCallCount = 0;
      secondSubscription = simpleBloc.viewModelStream.listen(expectAsync1((viewModel) {
        if (secondCallCount == 0) {
          expect(viewModel.value, '5');
        } else if (secondCallCount == 1) {
          expect(viewModel.value, '10');
          secondSubscription.cancel();
        }
        secondCallCount++;
      }, count: 2));

      await Future.delayed(Duration.zero);
      testEntity.merge(value: 10).send();
      expect(testEntity.buildCallCount, 1);
    });
  });
}
