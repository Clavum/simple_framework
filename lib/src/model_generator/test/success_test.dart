import 'package:test/test.dart';

import 'sources/success.dart';

/// -------------------------- IMPORTANT ----------------------------
/// Please read HOW_TO_RUN_TESTS.md for instructions on running tests.

void main() {
  group('generated models are functional', () {
    test('for Entity', () {
      var entity = const EntitySuccess();
      expect(entity.defaultParameter, 'defaultValue');
      expect(entity.nullableParameter, null);
      expect(entity.customClass.value, 'custom');

      entity = entity.merge(defaultParameter: 'newValue');
      expect(entity.defaultParameter, 'newValue');

      const newCustomClass = CustomClass('new');
      entity = entity.merge(
        nullableParameter: false,
        customClass: newCustomClass,
      );
      expect(entity.nullableParameter, false);
      expect(entity.customClass.value, 'new');

      expect(
        entity,
        const EntitySuccess(
          defaultParameter: 'newValue',
          nullableParameter: false,
          customClass: newCustomClass,
        ),
      );

      expect(entity.props, ['newValue', false, newCustomClass]);

      expect(entity.someMethod(10), 'newValue10');
    });

    test('for View Model', () {
      var viewModel = const ViewModelSuccess(requiredParameter: 10);
      expect(viewModel.defaultParameter, 'defaultValue');
      expect(viewModel.requiredParameter, 10);
      expect(viewModel.nullableParameter, null);

      viewModel = const ViewModelSuccess(
        requiredParameter: 5,
        defaultParameter: 'newValue',
        nullableParameter: false,
      );
      expect(viewModel.defaultParameter, 'newValue');
      expect(viewModel.requiredParameter, 5);
      expect(viewModel.nullableParameter, false);

      expect(
        viewModel,
        const ViewModelSuccess(
          defaultParameter: 'newValue',
          requiredParameter: 5,
          nullableParameter: false,
        ),
      );

      expect(viewModel.props, ['newValue', 5, false]);

      expect(viewModel.someMethod(10), 15);
    });

    test('for an empty Entity', () {
      var entity = const EmptyEntity();
      expect(entity.props, isEmpty);

      expect(entity, const EmptyEntity());
    });

    test('for an empty View Model', () {
      var viewModel = const EmptyViewModel();

      expect(viewModel.props, isEmpty);

      expect(viewModel, const EmptyViewModel());
    });
  });
}
