import 'package:test/test.dart';

import 'sources/basic.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  test('basic Entity functionality', () {
    var entity = const BasicEntity();
    // Uses default value.
    expect(entity.value, 0);

    // Can merge new values.
    entity = entity.merge(value: 10);
    expect(entity.value, 10);

    // Is equal to another instance with the same values.
    expect(entity, const BasicEntity(value: 10));

    // Props lists all field values.
    expect(entity.props, [10]);
  });

  test('basic ViewModel functionality', () {
    const viewModel = BasicViewModel(value: 10);
    // Returns provided value.
    expect(viewModel.value, 10);

    // Is equal to another instance with the same values.
    expect(viewModel, const BasicViewModel(value: 10));

    // Props lists all field values.
    expect(viewModel.props, [10]);

    // Only entities have setters.
    expect(() => (viewModel as dynamic).value = 10, throwsNoSuchMethodError);
  });
}
