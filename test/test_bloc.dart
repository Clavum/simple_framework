import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class TestBlocMock extends Mock implements TestBloc {
  TestBlocMock._();

  factory TestBlocMock() {
    TestBlocMock bloc = TestBlocMock._();
    when(bloc.onCreate).thenAnswer((_) async {});
    return bloc;
  }
}

class TestBloc extends Bloc {
  TestBloc._();

  factory TestBloc() {
    return MockClassProvider().getMockIfTest(real: TestBloc._(), mock: TestBlocMock());
  }
}
