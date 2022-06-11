import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

@visibleForTesting
M getSentModel<M extends RepositoryModel>() {
  List<dynamic> models = verify(() => Repository().sendModel<M>(captureAny())).captured;

  if (models.isEmpty) throw _noMatchingModelSent<M>();
  return models.firstWhere((model) => model.runtimeType == M, orElse: () {
    throw _noMatchingModelSent<M>();
  });
}

Exception _noMatchingModelSent<M>() {
  return Exception('getSentModel was called for the Type $M, but no '
      'matching Repository().sendModel calls were found.');
}