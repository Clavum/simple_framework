import 'package:test/test.dart';

import 'sources/various_parameters.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  test('Entity with all possible types of parameters', () {
    var entity = const VariousParametersEntity();
    expect(entity.defaultParameter, 'defaultValue');
    expect(entity.nullableParameter, null);
    expect(entity.customClass.value, 'custom');
    expect(entity.props.length, 3);
  });

  test('ViewModel with all possible types of parameters', () {
    var viewModel = const VariousParametersViewModel(requiredParameter: 10);
    expect(viewModel.defaultParameter, 'defaultValue');
    expect(viewModel.requiredParameter, 10);
    expect(viewModel.nullableParameter, null);
    expect(viewModel.customClass.value, 'custom');
    expect(viewModel.props.length, 4);
  });
}
