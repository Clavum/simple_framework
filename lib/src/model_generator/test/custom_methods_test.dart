import 'package:flutter_test/flutter_test.dart';
import 'sources/custom_methods.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  test('Entity with custom methods', () {
    var entity = const CustomMethodsEntity(value: 10);
    expect(entity.someMethod(10), 20);
  });

  test('Using custom method with modifier', () {
    customMethodsEntity.value = 10;
    expect(customMethodsEntity.get().someMethod(10), 20);
  });

  test('ViewModel with custom methods', () {
    var viewModel = const CustomMethodsViewModel(value: 10);
    expect(viewModel.someMethod(10), 20);
  });
}
