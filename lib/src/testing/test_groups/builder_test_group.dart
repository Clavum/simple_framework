import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void builderTest(String builderName, void Function() body) {
  test('$builderName test', () {
    setupCommonFallbackValues();

    addTearDown(() {
      reset(Repository());
      resetMocktailState();
      MockClassProvider().clearClasses();
    });

    body();
  });
}
