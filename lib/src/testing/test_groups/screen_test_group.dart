import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

@isTestGroup
@visibleForTesting
void screenTestGroup(String screenName, void Function() body) {
  group('$screenName test group', () {
    setUpAll(() async {
      await setupFirebaseMock();
    });

    tearDown(() {
      reset(Repository());
      resetMocktailState();
    });

    body();
  });
}