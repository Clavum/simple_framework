import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void screenTestGroup(String screenName, void Function() body) {
  group('$screenName tests', () {
    setUpAll(() async {
      await setupFirebaseMock();
      setupCommonFallbackValues();
    });

    tearDown(() {
      if (Repository() is RepositoryMock) {
        reset(Repository());
      }
      resetMocktailState();
      MockClassProvider().clear();
    });

    body();
  });
}
