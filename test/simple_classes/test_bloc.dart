import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import 'test_entity.dart';

class TestBlocMock extends Mock implements TestBloc {}

class TestBloc extends Bloc {
  TestBloc._();

  factory TestBloc() {
    return MockClassProvider().getMockIfTest(
      real: () => TestBloc._(),
      mock: () => TestBlocMock(),
    );
  }

  void buildCalled() {
    Repository().set(testEntity.merge(buildCallCount: testEntity.buildCallCount + 1));
  }
}
