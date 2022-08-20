import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_framework/src/core/models/model.dart';
import 'package:simple_framework/src/core/models/view_model.dart';
import 'package:simple_framework/src/core/repository.dart';
import 'package:simple_framework/src/core/ui/screen.dart';
import 'package:meta/meta.dart';

abstract class Bloc<V extends ViewModel> {
  bool hasBeenCreated = false;

  V? _currentViewModel;

  final StreamController<V> _viewModelStreamController = StreamController<V>.broadcast(sync: true);

  final Map<Type, StreamSubscription<void>> _entityStreams = {};

  late final BuildContext Function() _buildContextGetter;

  Bloc() {
    _viewModelStreamController.onListen = () {
      if (hasBeenCreated) _sendModel();
    };
  }

  void onInitState() async {
    if (!hasBeenCreated) {
      hasBeenCreated = true;
      await onCreate();
    }
    _sendModel();
  }

  Stream<V> get viewModelStream => _viewModelStreamController.stream;

  @internal
  set setBuildContextGetter(BuildContext Function() getter) => _buildContextGetter = getter;

  BuildContext get context => _buildContextGetter();

  void _sendModel() async {
    Repository().onFetch = _onModelRequested;
    final V nextViewModel = await buildViewModel();
    Repository().onFetch = null;
    if (shouldSendNewModel(_currentViewModel, nextViewModel)) {
      _currentViewModel = nextViewModel;
      _viewModelStreamController.add(nextViewModel);
    }
  }

  void _onModelRequested<M extends RepositoryModel>() {
    _entityStreams[M] ??= Repository().streamOf<M>().listen(_onEntityUpdated);
  }

  void _onEntityUpdated(_) => _sendModel();

  /// Optional method to override, to trigger events when the [Bloc] is first created by a [Screen].
  /// If your onCreate method is asynchronous, the [Screen] will display its loading screen until
  /// the method completes.
  FutureOr<void> onCreate() async {}

  FutureOr<V> buildViewModel();

  /// By default, the [Bloc] will only send a new [ViewModel] if it has changed. You can override
  /// this method to customize the behavior.
  bool shouldSendNewModel(V? currentViewModel, V newViewModel) => currentViewModel != newViewModel;

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  @mustCallSuper
  void dispose() {
    for (final subscription in _entityStreams.values) {
      subscription.cancel();
    }
  }
}
