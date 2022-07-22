import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:meta/meta.dart';

class Repository {
  Repository._();

  final List<Model> _models = [];

  final Map<Type, StreamController> _streams = {};

  final Map<Type, ServiceModelStatus> _serviceModelStatuses = {};

  void Function<M extends RepositoryModel>()? _fetchCallback;

  factory Repository() {
    //TODO: Use Mockable
    return MockClassProvider().getMockIfTest(
      real: () => Repository._(),
      mock: () => RepositoryMock(),
    );
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
  M set<M extends RepositoryModel>(M model) {
    _models.retainWhere((element) => element.runtimeType != model.runtimeType);
    _models.add(model);
    return model;
  }

  /// Sends a [Model] to its corresponding Stream. This notifies any [Bloc] streaming from this
  /// [Model] to send a new ViewModel. The provided [model] will also be set in the [Repository].
  void sendModel(RepositoryModel model) {
    _models.retainWhere((element) => element.runtimeType != model.runtimeType);
    _models.add(model);
    if (_streams.containsKey(model.runtimeType)) {
      _streams[model.runtimeType]!.add(model);
    } else {
      if (model is Entity) {
        debugPrint('There is no Screen subscribed to receive ${model.runtimeType}');
      }
    }
  }

  /// Whether the [Repository] contains the [Model] of the specified type.
  bool containsModel<M extends RepositoryModel>() {
    for (var model in _models) {
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

  Stream streamOf<M extends RepositoryModel>() {
    return (_streams[M] = _streams.putIfAbsent(M, () => StreamController<M>.broadcast())).stream;
  }

  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    /// If the ServiceModel already exists and is valid, it is returned.
    if (Repository().getServiceModelStatus<M>() == ServiceModelStatus.valid) {
      return Repository().get<M>(model);
    }

    /// If the ServiceModel is loading, that means it is currently being loaded, and will send it
    /// once done. This code waits for and sends the next model from the stream.
    if (Repository().getServiceModelStatus<M>() == ServiceModelStatus.loading) {
      await for (var model in Repository().streamOf<M>()) {
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

  @internal
  set onFetch(void Function<M extends RepositoryModel>()? callback) {
    _fetchCallback = callback;
  }

  /// Because [Repository] uses Mock Factories, this method is needed to avoid needing to cast
  /// as a [RepositoryMock]. Because 'Repository()' will always return a [RepositoryMock] in tests,
  /// this method will never be called on a real [Repository]. See the [RepositoryMock] class for
  /// the actual implementation, as well as usage information.
  @visibleForTesting
  void addMockModel<M extends RepositoryModel>(M model) {}
}
