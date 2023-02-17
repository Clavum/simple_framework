import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:simple_framework/simple_framework.dart';

/// A test group for any class not from the framework. Consider using:
/// [presenterTestGroup] for [Presenter]s
/// [blocTestGroup] for [Bloc]s
/// [builderTest] for ModelBuilders
@isTestGroup
@visibleForTesting
void standardTestGroup(String className, void Function() body) {
  group('$className tests', () {
    setUpAll(setupCommonFallbackValues);

    tearDown(commonTearDown);

    body();
  });
}
