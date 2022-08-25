import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';

import '../test_classes/broken_service_model.dart';
import '../test_classes/test_service_model.dart';

void main() {
  group('getServiceModel', () {
    setUp(() {
      Repository().set(const TestServiceModel(state: TestServiceModelState.fromRepository));
      Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.invalid);
    });

    test('model is already valid', () async {
      Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.valid);
      TestServiceModel serviceModel = await Repository().getServiceModel(const TestServiceModel());

      expect(serviceModel.state, TestServiceModelState.fromRepository);
    });

    test('model gets loaded', () async {
      TestServiceModel? serviceModel;

      bool modelSent = false;
      late StreamSubscription subscription;
      subscription = Repository().streamOf<TestServiceModel>().listen((model) {
        modelSent = true;
        subscription.cancel();
      });

      void setModelAsync() async {
        serviceModel = await Repository().getServiceModel(const TestServiceModel());
      }

      Repository().setServiceModelStatus<TestServiceModel>(ServiceModelStatus.invalid);

      setModelAsync();
      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.loading);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(serviceModel, isNotNull);
      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.valid);
      expect(serviceModel?.state, TestServiceModelState.fromLoad);

      expect(modelSent, isTrue);
    });

    test('when load method returns wrong class', () async {
      Repository().setServiceModelStatus<BrokenServiceModel>(ServiceModelStatus.invalid);

      bool threwError = false;
      try {
        await Repository().getServiceModel(const BrokenServiceModel());
      } on ArgumentError {
        threwError = true;
      }
      expect(threwError, true);
      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.invalid);
    });

    test('when loaded multiple times', () async {
      TestServiceModel? firstModel;
      TestServiceModel? secondModel;

      void setFirstModelAsync() async {
        firstModel = await Repository().getServiceModel(const TestServiceModel());
      }

      setFirstModelAsync();

      expect(Repository().getServiceModelStatus<TestServiceModel>(), ServiceModelStatus.loading);

      void setSecondModelAsync() async {
        secondModel = await Repository().getServiceModel(const TestServiceModel());
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
