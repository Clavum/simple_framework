import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:simple_framework/simple_framework.dart';
import 'package:utilities/utilities.dart';

class Repository {
  Repository._();

  final List<Model> _models = [];

  final Map<Type, StreamController> _streams = {};

  final Map<Type, ServiceModelStatus> _serviceModelStatuses = {};

  factory Repository() {
    return MockClassProvider().getMockIfTest(real: Repository._(), mock: RepositoryMock());
  }

  /// Get a [Model] from the [Repository]. Ideal usage is:
  /// ```dart
  /// Repository().get(ExampleModel());
  /// ```
  /// NOT:
  /// ```dart continued
  /// Repository().get<ExampleModel>(ExampleModel());
  /// ```
  ///
  /// The provided model is required because it is what will be used if the [Model] does not exist
  /// in the [Repository] yet.
  M get<M extends RepositoryModel>(M model) {
    return _models.firstWhere((element) => element.runtimeType == model.runtimeType, orElse: () {
      _models.add(model);
      return model;
    }) as M;
  }

  /// Set a [Model] in the [Repository]. See comments on [get] above. The provided model will be
  /// used if the [Model] does not exist in the [Repository] yet.
  M set<M extends RepositoryModel>(M model) {
    _models.retainWhere((element) => element.runtimeType != model.runtimeType);
    _models.add(model);
    return model;
  }

  /// Sends a [Model] to its corresponding Stream. This allows any [Screen] streaming from this
  /// [Model] to be updated. The repository is updated at the same time, so using [set] before
  /// [sendModel] is redundant.
  void sendModel(RepositoryModel model) {
    // The type parameters are used to verify only Models are passed as a parameter, but runtimeType
    // is used instead of the type parameter because this method is typically used by the send
    // method in the models, at which point we do not know the type.
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

  ServiceModelStatus getServiceModelStatus<S extends ServiceModel>() {
    if (!containsModel<S>()) return ServiceModelStatus.invalid;
    return _serviceModelStatuses[S] ?? ServiceModelStatus.invalid;
  }

  void setServiceModelStatus<S extends ServiceModel>(ServiceModelStatus status) {
    _serviceModelStatuses[S] = status;
  }

  /// Because [Repository] uses Mock Factories, this method is needed to avoid needing to cast
  /// as a [RepositoryMock]. Because 'Repository()' will always return a [RepositoryMock] in tests,
  /// this method will never be called on a real [Repository]. See the [RepositoryMock] class for
  /// the actual implementation, as well as usage information.
  @visibleForTesting
  void addMockModel<M extends RepositoryModel>(M model) => throw _addMockModelCalledOnReal();
}

Exception _addMockModelCalledOnReal() {
  return Exception('addMockModel was called on a real instance of the Repository.');
}
