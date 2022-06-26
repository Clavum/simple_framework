import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:simple_framework/src/testing/common_test_methods.dart';

@isTestGroup
@visibleForTesting
void builderTest(String builderName, void Function() body) {
  test('$builderName test', () {
    setupCommonFallbackValues();

    addTearDown(() {
      commonTearDown();
    });

    body();
  });
}
