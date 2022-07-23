import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class StreamSubscriptionMock<E extends Object> extends Mock implements StreamSubscription<E> {
  @override
  Future<void> cancel() async {}
}

class StreamMock<E extends Object> extends Mock implements Stream<E> {
  @override
  StreamSubscription<E> listen(
    void Function(E event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return StreamSubscriptionMock<E>();
  }
}

class RepositoryMock extends Mock implements Repository {
  /// Use this method in the `setUp` method of Bloc tests to mock a Model to be returned when it
  /// is attempted to be fetched.
  void addMockModel<M extends RepositoryModel>(M mockModel) {
    if (M == RepositoryModel) throw _addMockModelCalledWithoutType();
    registerFallbackValue(mockModel);
    when(() => get<M>(any())).thenAnswer((_) => mockModel);
    when(() => set<M>(any())).thenAnswer((_) => mockModel);
  }

  @override
  Stream<M> streamOf<M extends RepositoryModel>() {
    return StreamMock<M>();
  }
}

Error _addMockModelCalledWithoutType() {
  return ArgumentError('addMockModel was called without a specific model type.');
}
