import 'package:simple_framework/simple_framework.dart';

import 'test_entity.dart';
import 'test_view_model.dart';

class TestBloc extends Bloc<TestViewModel> {
  @override
  Future<TestViewModel> buildViewModel() async {
    return TestViewModel(
      value: testEntity.value.toString(),
    );
  }

  void buildCalled() {
    Repository().set(testEntity.merge(buildCallCount: testEntity.buildCallCount + 1));
  }
}
