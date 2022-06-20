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
  });
}
