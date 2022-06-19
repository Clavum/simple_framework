import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

import '../../test_entity.dart';

void main() {
  test('Entity send', () {
    TestEntity testEntity = const TestEntity(value: 1);
    testEntity.send();

    verify(() => Repository().sendModel(testEntity)).called(1);
  });
}
