import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class StreamSubscriptionMock extends Mock implements StreamSubscription<Model> {
  @override
  Future<void> cancel() async {}
}

class StreamMock extends Mock implements Stream<Model> {
  StreamMock() {
    when(() => listen(any())).thenAnswer((Invocation invocation) {
      return StreamSubscriptionMock();
    });
  }
}

class RepositoryMock extends Mock implements Repository {
  /// Use this method in the `setUp` method of Bloc tests to mock a Model to be returned when it
  /// is tried to be fetched.
  @override
  void addMockModel<M extends RepositoryModel>(M mockModel) {
    if (M == RepositoryModel) throw _addMockModelCalledWithoutType();
    registerFallbackValue(mockModel);
    when(() => get<M>(any())).thenAnswer((_) => mockModel);
    when(() => set<M>(any())).thenAnswer((_) => mockModel);
  }

  @override
  Stream<dynamic> streamOf<M extends RepositoryModel>() {
    return StreamMock();
  }
}

Error _addMockModelCalledWithoutType() {
  return ArgumentError('addMockModel was called without a specific model type.');
}
