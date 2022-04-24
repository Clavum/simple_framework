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

  /// Get an Entity from the Repository. Ideal usage is:
  /// Repository().get(ExampleEntity());
  /// NOT:
  /// Repository().get<ExampleEntity>(ExampleEntity());
  ///
  /// The provided entity is required because it is what will be used if the Entity does not exist
  /// in the Repository yet. It is then redundant to provide the Type parameter, as Dart is able to
  /// infer the Type from the parameter.
  E get<E extends Entity>(E entity) {
    return _entities.firstWhere((entity) => entity.runtimeType == E, orElse: () {
      _entities.add(entity);
      return entity;
    }) as E;
  }

  /// Set an Entity in the Repository. See comments on [get] above. The provided entity will be used
  /// if the Entity does not exist in the Repository yet.
  E set<E extends Entity>(E entity) {
    _entities.retainWhere((element) => element.runtimeType != E);
    _entities.add(entity);
    return entity;
  }

  /// Sends an Entity to its corresponding Stream. This allows any Screen streaming from this Entity
  /// to be updated. The repository is updated at the same time, so make sure not to use [set]
  /// before [sendEntity], which is unnecessary.
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

  /// Is generally meant to be used by the framework only but is also available for you to use in
  /// rare circumstances.
  Stream streamOf<E extends Entity>() {
    return (_streams[E] = _streams.putIfAbsent(E, () => StreamController<E>.broadcast())).stream;
  }

  /// Because [Repository] uses Mock Factories, this method is needed to avoid needing to casting
  /// as a [MockRepository]. Because 'Repository()' will always return a [MockRepository] in tests,
  /// this method should never be called on a real [Repository]. See the [MockRepository] below for
  /// the actual implementation, as well as usage information.
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
  /// Use this method in the `setUp` method of Bloc tests to mock an Entity to be returned when it
  /// is tried to be fetched.
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
