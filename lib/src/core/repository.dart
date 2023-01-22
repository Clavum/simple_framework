//ignore_for_file: avoid_catching_errors

part of 'core.dart';

class Repository {
  static Repository? _instance;

  Repository._();

  final List<Model> _models = [];

  final Map<Type, StreamController> _streams = {};

  final Map<Type, ServiceModelStatus> _serviceModelStatuses = {};

  void Function<M extends RepositoryModel>()? _fetchCallback;

  factory Repository() {
    _instance ??= Repository._();
    return mockable(() => _instance!);
  }

  /// Get a [Model] from the [Repository]. A [model] is required because it is what will be used if
  /// the [Model] does not exist in the [Repository] yet.
  M get<M extends RepositoryModel>(M model) {
    _fetchCallback?.call<M>();
    return _models.firstWhere((element) => element.runtimeType == model.runtimeType, orElse: () {
      _models.add(model);
      return model;
    }) as M;
  }

  /// Set a [Model] in the [Repository]. Any existing model of the same type will be replaced.
  void set<M extends RepositoryModel>(M model) {
    _models
      ..retainWhere((element) => element.runtimeType != model.runtimeType)
      ..add(model);
  }

  /// Sends a [Model] to its corresponding Stream. This notifies any [Bloc] streaming from this
  /// [Model] to send a new ViewModel. The provided [model] will also be set in the [Repository].
  ///
  /// If in debug mode, the [model] is an [Entity], and no [Screen] is subscribed to the [Entity],
  /// a warning will be printed to help with debugging, as it may indicate a bug.
  /// It's also possible that it is not a bug and that it is understood the screen may or may not
  /// be displayed currently. In this case, the warning may become quite terribly annoying, like
  /// why-does-this-exist sort of annoying. So, to disable it, just provide [silent], and you will
  /// have peace again. At least, until the next time you forget to provide [silent].
  void sendModel(RepositoryModel model, {bool silent = false}) {
    _models
      ..retainWhere((element) => element.runtimeType != model.runtimeType)
      ..add(model);
    if (_streams.containsKey(model.runtimeType)) {
      _streams[model.runtimeType]!.add(model);
    } else {
      if (kDebugMode && model is Entity && !silent) {
        SimpleFrameworkSettings.onLog(LogLevel.warning,
            'An instance of ${model.runtimeType} was sent, but no Screen is subscribed to receive it');
      }
    }
  }

  /// Whether the [Repository] contains the [Model] of the specified type.
  bool containsModel<M extends RepositoryModel>() {
    for (final model in _models) {
      if (model.runtimeType == M) {
        return true;
      }
    }
    return false;
  }

  /// Removes the [Model] of the specified type from the [Repository], if it exists.
  void removeModel<M extends RepositoryModel>() {
    _models.removeWhere((model) => model.runtimeType == M);
  }

  /// Returns a stream which emits every model of type [M] that is sent with [sendModel].
  Stream<M> streamOf<M extends RepositoryModel>() {
    void _onCancel() {
      _streams[M]?.close();
      _streams.remove(M);
    }

    _streams.putIfAbsent(M, () => StreamController<M>.broadcast(sync: true, onCancel: _onCancel));
    return _streams[M]!.stream as Stream<M>;
  }

  /// Whether the [Repository] has an active model stream of the specified type. Because [streamOf]
  /// is typically only used by [Bloc]s, this is a way to check if using [sendModel] with an
  /// instance of [M] would possibly cause a visual update.
  ///
  /// This can be used to avoid unnecessary work. For example, you could have a timer on repeat
  /// that refreshes the user's data, but only if that specific data is being displayed.
  bool hasActiveStream<M extends RepositoryModel>() {
    return _streams.containsKey(M);
  }

  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    /// If the ServiceModel already exists and is valid, it is returned.
    if (Repository().getServiceModelStatus<M>() == ServiceModelStatus.valid) {
      return Repository().get<M>(model);
    }

    /// If the ServiceModel is loading, that means it is currently being loaded, and will send it
    /// once done. This code waits for and sends the next model from the stream.
    if (Repository().getServiceModelStatus<M>() == ServiceModelStatus.loading) {
      await for (final model in Repository().streamOf<M>()) {
        return model;
      }
    }

    /// In all other scenarios, use the ServiceModel's build method to load itself.
    Repository().setServiceModelStatus<M>(ServiceModelStatus.loading);
    M loadedModel;
    try {
      loadedModel = await model.load() as M;
    } on TypeError {
      Repository().setServiceModelStatus<M>(ServiceModelStatus.invalid);
      throw ArgumentError('The load method for $M returned a Model of a type other than itself.');
    }
    Repository().setServiceModelStatus<M>(ServiceModelStatus.valid);

    /// Sending as apposed to setting here is important. Most importantly, it is needed to notify
    /// that the model is done loading. Another advantage is rebuilding Screens based on this model,
    /// because we might as well display the latest information.
    loadedModel.send();

    _fetchCallback?.call<M>();
    return loadedModel;
  }

  ServiceModelStatus getServiceModelStatus<S extends ServiceModel>() {
    if (_serviceModelStatuses[S] == ServiceModelStatus.valid && !containsModel<S>()) {
      _serviceModelStatuses[S] = ServiceModelStatus.invalid;
    }
    return _serviceModelStatuses[S] ?? ServiceModelStatus.invalid;
  }

  void setServiceModelStatus<S extends ServiceModel>(ServiceModelStatus status) {
    _serviceModelStatuses[S] = status;
  }

  void reset() => _instance = null;
}
