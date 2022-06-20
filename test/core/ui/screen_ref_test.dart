import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../simple_classes/broken_service_model.dart';
import '../../simple_classes/test_entity.dart';
import '../../simple_classes/test_service_model.dart';

void main() {
  late ScreenRef ref;
  late int callbackCallCount;

  setUp(() {
    callbackCallCount = 0;
    ref = ScreenRef(<T extends RepositoryModel>() async {
      callbackCallCount++;
    });
  });

  void setMockServiceModelStatus<S extends ServiceModel>(ServiceModelStatus status) {
    when(() => Repository().getServiceModelStatus<S>()).thenAnswer((_) => status);
  }

  test('getEntity', () {
    Repository().addMockModel(const TestEntity());
    ref.getEntity(const TestEntity());

    verify(() => Repository().get(const TestEntity())).called(1);
    expect(callbackCallCount, 1);
  });

  test('throws errors if disposed', () {
    ref.close();

    expect(() => ref.getEntity(const TestEntity()), throwsStateError);
    expect(() => ref.getServiceModel(TestServiceModel()), throwsStateError);
  });

  group('getServiceModel', () {
    Repository().addMockModel(TestServiceModel(state: TestServiceModelState.fromRepository));

    test('firstLoad = false', () async {
      ref.firstLoad = false;
      TestServiceModel serviceModel = await ref.getServiceModel(TestServiceModel());

      expect(serviceModel.state, TestServiceModelState.fromRepository);
    });

    test('model is already valid', () async {
      setMockServiceModelStatus<TestServiceModel>(ServiceModelStatus.valid);
      TestServiceModel serviceModel = await ref.getServiceModel(TestServiceModel());

      expect(serviceModel.state, TestServiceModelState.fromRepository);
    });

    //Loading scenario needs to be tested without mocks.

    test('model gets loaded', () async {
      TestServiceModel? serviceModel;

      void setModelAsync() async {
        serviceModel = await ref.getServiceModel(TestServiceModel());
      }

      setMockServiceModelStatus<TestServiceModel>(ServiceModelStatus.invalid);

      setModelAsync();
      verify(() => Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.loading))
          .called(1);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(serviceModel, isNotNull);
      verify(() => Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.valid))
          .called(1);
      expect(serviceModel?.state, TestServiceModelState.fromLoad);

      verify(() => Repository().sendModel(serviceModel!)).called(1);
      expect(callbackCallCount, 1);
    });

    test('when load method returns wrong class', () async {
      setMockServiceModelStatus<BrokenServiceModel>(ServiceModelStatus.invalid);

      bool threwError = false;
      try {
        await ref.getServiceModel(BrokenServiceModel());
      } on ArgumentError {
        threwError = true;
      }
      expect(threwError, true);
      verify(() =>
              Repository().setServiceModelStatus<BrokenServiceModel>(ServiceModelStatus.invalid))
          .called(1);
    });

    test('when loaded by multiple refs', () async {
      MockClassProvider().forceUseRealClass<Repository>();
      ScreenRef secondRef = ScreenRef(<T extends RepositoryModel>() async {});

      TestServiceModel? firstModel;
      TestServiceModel? secondModel;

      void setFirstModelAsync() async {
        firstModel = await ref.getServiceModel(TestServiceModel());
      }

      setFirstModelAsync();

      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.loading);

      void setSecondModelAsync() async {
        secondModel = await secondRef.getServiceModel(TestServiceModel());
      }

      await Future.delayed(const Duration(milliseconds: 50));
      setSecondModelAsync();

      await Future.delayed(const Duration(milliseconds: 50));

      // There were two requests to get the same model, at different times, but they both were
      // completed at the same time because only one load attempt was made. The second call to load
      // did not make a second load attempt, but instead depended on the first.
      expect(firstModel, isNotNull);
      expect(secondModel, isNotNull);
      expect(firstModel, secondModel);
    });
  });
}
