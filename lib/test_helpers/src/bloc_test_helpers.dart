//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

@isTest
@visibleForTesting
void testSynchronizeWithRepo<E extends Entity, O extends Entity>(
  Bloc bloc,
  O otherEntity,
  void Function(E) body,
) {
  test('synchronizeWithRepo Test for ${otherEntity.runtimeType}', () {
    Repository().addMockEntity<O>(otherEntity);
    bloc.onCreate();
    body(bloc.runEntityCombiner<O>(otherEntity) as E);
  });
}

@isTestGroup
@visibleForTesting
void blocTestGroup<B extends Bloc>(B Function() blocCreator, void Function(B) body) {
  group('$B tests', () {
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
