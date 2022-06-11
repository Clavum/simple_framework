import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

@isTestGroup
@visibleForTesting
void builderTest(String builderName, void Function() body) {
  test('$builderName test', () {
    addTearDown(() {
      reset(Repository());
      resetMocktailState();
    });

    body();
  });
}
