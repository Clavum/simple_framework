import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

/// Takes an object, and based on its type, sets up some common default method stubs to avoid
/// errors. It is automatically used on mocks provided to the MockClassProvider, but can also be
/// used by the developer on custom mocks.
void setupCommonMockStubs(Object object) {
  if (object is Bloc) {
    when(object.onCreate).thenAnswer((_) async {});
  }
}
