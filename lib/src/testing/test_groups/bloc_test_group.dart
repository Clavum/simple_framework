import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void blocTestGroup<B extends Bloc>(B Function() blocCreator, void Function(B) body) {
  group('$B test group', () {
    setupCommonFallbackValues();
    MockClassProvider().forceUseRealClass<B>();
    B bloc = blocCreator();

    setUp(() {
      MockClassProvider().forceUseRealClass<B>();
      bloc = blocCreator();
    });

    tearDown(() {
      bloc.dispose();
      reset(Repository());
      resetMocktailState();
      MockClassProvider().clear();
    });

    body(bloc);
  });
}
