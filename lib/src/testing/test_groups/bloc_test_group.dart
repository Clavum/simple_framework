import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:simple_framework/simple_framework.dart';

@isTestGroup
@visibleForTesting
void blocTestGroup<B extends Bloc>(B Function() blocCreator, void Function(B Function()) body) {
  late B bloc;

  B blocGetter() => bloc;

  group('$B tests', () {
    setupCommonFallbackValues();
    bloc = blocCreator();

    setUp(() {
      bloc = blocCreator();
    });

    tearDown(() {
      bloc.onDispose();
      commonTearDown();
    });

    body(blocGetter);
  });
}
