import 'package:simple_framework/simple_framework.dart';

import 'test_entity.dart';
import 'test_view_model.dart';

class TestBloc extends Bloc<TestViewModel> {
  @override
  TestViewModel buildViewModel() => TestViewModel(value: testEntity.value.toString());
}
