import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

@visibleForTesting
E getSentEntity<E extends Entity>() {
  List<dynamic> entities = verify(() => Repository().sendEntity(captureAny())).captured;

  if (entities.isEmpty) throw _noMatchingEntitySent<E>();
  return entities.firstWhere((entity) => entity.runtimeType == E, orElse: () {
    throw _noMatchingEntitySent<E>();
  });
}

Exception _noMatchingEntitySent<E extends Entity>() {
  return Exception('getSentEntity was called for the Type $E, but no '
      'matching Repository().sendEntity calls were found.');
}
