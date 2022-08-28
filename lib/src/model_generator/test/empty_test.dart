import 'package:test/test.dart';

import 'sources/empty.dart';

/// -------------------------| IMPORTANT |---------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  test('Entity with no fields', () {
    const entity = EmptyEntity();
    expect(entity.props, isEmpty);

    expect(entity, const EmptyEntity());
  });

  test('ViewModel with no fields', () {
    const viewModel = EmptyViewModel();

    expect(viewModel.props, isEmpty);

    expect(viewModel, const EmptyViewModel());
  });
}
