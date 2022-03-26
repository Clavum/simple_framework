import 'package:simple_framework/entity/entity.dart';

typedef RepositorySubscription<T> = void Function(T);

/// After I make my own testWidget, testBloc, testScreen methods:
/// Make a method here called "setMock" or something like that which sets the repository to be
/// mocked instead. This would be called automatically at the start of test methods.

class Repository {
  Repository._();

  static final Repository _repository = Repository._();

  List<Entity> entities = [];

  factory Repository() {
    return _repository;
  }

  E get<E extends Entity>(E entity) {
    return entities.firstWhere((entity) => entity.runtimeType == E, orElse: () {
      entities.add(entity);
      return entity;
    }) as E;
  }

  void set<E extends Entity>(E entity) {
    entities.retainWhere((element) => element.runtimeType != E);
    entities.add(entity);
  }
}
