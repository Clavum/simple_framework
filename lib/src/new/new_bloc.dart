import 'dart:async';

import 'package:clean_framework_internal/clean_framework_internal.dart';
import 'package:clean_framework_internal/src/defaults/repository.dart';
import 'package:flutter/material.dart';

class _NotifyingRepository extends Repository {
  final Repository _realRepository;

  final void Function<E extends Entity>() _fetchCallback;

  _NotifyingRepository(this._realRepository, this._fetchCallback);

  @override
  E get<E extends Entity>(RepositoryScope? scope) {
    _fetchCallback();
    return _realRepository.get(scope);
  }
}

abstract class NewBloc<V extends ViewModel> extends Bloc {
  late final _NotifyingRepository _repository;

  V? _currentViewModel;

  StreamController<V> _viewModelStreamController =
  StreamController<V>(sync: true);

  final Map<Type, StreamSubscription<void>> _entityStreams = {};

  NewBloc(Repository repository) {
    _repository = _NotifyingRepository(repository, _onEntityRequested);

    _viewModelStreamController.onListen = _sendModel;
  }

  V buildViewModel();

  Repository get repository => _repository;

  Stream<V> get viewModelStream => _viewModelStreamController.stream;

  void _sendModel() {
    final V nextViewModel = buildViewModel();
    if (nextViewModel != _currentViewModel) {
      _currentViewModel = nextViewModel;
      _viewModelStreamController.add(nextViewModel);
    }
  }

  void _onEntityRequested<E extends Entity>() {
    _entityStreams[E] ??= _repository.streamOf<E>().listen(_onEntityUpdated);
  }

  void _onEntityUpdated(_) => _sendModel();

  @override
  @mustCallSuper
  void dispose() {
    _viewModelStreamController.close();
  }
}
