import 'dart:async';

import 'package:simple_framework/src/core/models/repository_model.dart';
import 'package:simple_framework/src/core/models/view_model.dart';
import 'package:simple_framework/src/core/repository.dart';

//TODO: Add a test when the buildViewModel uses different entities each request, make sure it
//adds listeners.
abstract class Bloc<V extends ViewModel> {
  bool hasBeenCreated = false;

  V? _currentViewModel;

  final StreamController<V> _viewModelStreamController = StreamController<V>(sync: true);

  final Map<Type, StreamSubscription<void>> _entityStreams = {};

  Bloc() {
    _viewModelStreamController.onListen = () async {
      if (!hasBeenCreated) {
        hasBeenCreated = true;
        await onCreate();
      }
      _sendModel();
    };
  }

  Stream<V> get viewModelStream => _viewModelStreamController.stream;

  void _sendModel() async {
    Repository().onFetch = _onModelRequested;
    final V nextViewModel = await buildViewModel();
    Repository().onFetch = null;
    if (nextViewModel != _currentViewModel) {
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

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void dispose() {}
}
