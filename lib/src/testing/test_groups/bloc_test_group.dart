import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void blocTestGroup<B extends Bloc>(B Function() blocCreator, void Function(B) body) {
  group('$B test group', () {
    B bloc = blocCreator();

    setUp(() {
      bloc = blocCreator();
    });

    setUpAll(() {
      setupCommonFallbackValues();
    });

    tearDown(() {
      bloc.dispose();
      reset(Repository());
      resetMocktailState();
    });

    body(bloc);
  });
}
