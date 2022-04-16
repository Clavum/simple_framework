import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class Repository {
  Repository._();

  final List<Entity> _entities = [];

  final Map<Type, StreamController> _streams = {};

  factory Repository() {
    return MockClassProvider().get(real: Repository._(), mock: MockRepository());
  }

  E get<E extends Entity>(E entity) {
    return _entities.firstWhere((entity) => entity.runtimeType == E, orElse: () {
      _entities.add(entity);
      return entity;
    }) as E;
  }

  E set<E extends Entity>(E entity) {
    _entities.retainWhere((element) => element.runtimeType != E);
    _entities.add(entity);
    return entity;
  }

  void sendEntity(entity) {
    _entities.retainWhere((element) => element.runtimeType != entity.runtimeType);
    _entities.add(entity);
    if (_streams.containsKey(entity.runtimeType)) {
      _streams[entity.runtimeType]!.add(entity);
    } else {
      if (kDebugMode) {
        print('There is no Screen subscribed to receive ${entity.runtimeType}');
      }
    }
  }

  Stream streamOf<E extends Entity>() {
    return (_streams[E] = _streams.putIfAbsent(E, () => StreamController<E>.broadcast())).stream;
  }

  @visibleForTesting
  void addMockEntity<E extends Entity>(E entity) => throw _addMockEntityCalledOnReal();
}

class MockStreamSubscription extends Mock implements StreamSubscription<Entity> {}

class MockStream extends Mock implements Stream<Entity> {
  MockStream() {
    when(() => listen(any())).thenAnswer((Invocation invocation) {
      return MockStreamSubscription();
    });
  }
}

class MockRepository extends Mock implements Repository {
  @override
  void addMockEntity<E extends Entity>(E mockEntity) {
    if (E == Entity) throw _addMockEntityCalledWithoutType();
    registerFallbackValue(mockEntity);
    when(() => get<E>(any())).thenAnswer((_) => mockEntity);
    when(() => set<E>(any())).thenAnswer((_) => mockEntity);
  }

  @override
  Stream<dynamic> streamOf<E extends Entity>() {
    return MockStream();
  }
}

Exception _addMockEntityCalledOnReal() {
  return Exception('addMockEntity was called on a real instance of the Repository.');
}

Exception _addMockEntityCalledWithoutType() {
  return Exception('addMockEntity was called without a specific entity type.');
}