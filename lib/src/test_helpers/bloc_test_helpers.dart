//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

@isTestGroup
@visibleForTesting
void blocTestGroup<B extends Bloc>(B Function() blocCreator, void Function(B) body) {
  group('$B test group', () {
    B bloc = blocCreator();

    setUp(() {
      bloc = blocCreator();
      bloc.addEntityToMocks();
    });

    tearDown(() {
      bloc.dispose();
      reset(Repository());
      resetMocktailState();
    });

    body(bloc);
  });
}
