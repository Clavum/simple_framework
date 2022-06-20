import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_entity.dart';
import '../../test_service_model.dart';

void main() {
  late ScreenRef ref;
  late int callbackCallCount;

  setUp(() {
    callbackCallCount = 0;
    ref = ScreenRef(<T extends RepositoryModel>() async {
      callbackCallCount++;
    });
  });

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
      Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.valid);
      TestServiceModel serviceModel = await ref.getServiceModel(TestServiceModel());

      expect(serviceModel.state, TestServiceModelState.fromRepository);
    });

    //Loading scenario needs to be tested without mocks.

    test('model gets loaded', () async {
      TestServiceModel? serviceModel;

      void setModelAsync() async {
        serviceModel = await ref.getServiceModel(TestServiceModel());
      }

      Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.invalid);
      setModelAsync();

      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.loading);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(serviceModel, isNotNull);
      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.valid);
      expect(serviceModel?.state, TestServiceModelState.fromLoad);

      verify(() => Repository().sendModel(serviceModel!)).called(1);
      expect(callbackCallCount, 1);
    });
  });
}
