import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import 'test_entity.dart';
import 'test_view_model.dart';

class TestBuilderMock extends Mock implements TestBuilder {
  TestBuilderMock._();

  factory TestBuilderMock() {
    TestBuilderMock testBuilderMock = TestBuilderMock._();
    when(() => testBuilderMock.build(any()))
        .thenAnswer((_) => Future.value(TestViewModel(value: '5')));
    return testBuilderMock;
  }
}

class TestBuilder extends ModelBuilder<TestViewModel> {
  TestBuilder._();

  factory TestBuilder() {
    return MockClassProvider().getMockIfTest(
      real: () => TestBuilder._(),
      mock: () => TestBuilderMock(),
    );
  }

  @override
  Future<TestViewModel> build(ref) async {
    TestEntity testEntity = ref.getEntity(const TestEntity());

    return TestViewModel(
      value: testEntity.value.toString(),
    );
  }
}
