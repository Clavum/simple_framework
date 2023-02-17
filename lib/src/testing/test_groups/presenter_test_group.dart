import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:simple_framework/src/testing/common_test_methods.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void presenterTestGroup(String presenterName, void Function() body) {
  group('$presenterName tests', () {
    setUpAll(() async {
      await setupFirebaseMock();
      setupCommonFallbackValues();
    });

    tearDown(commonTearDown);

    body();
  });
}
