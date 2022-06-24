import 'package:meta/meta.dart';
import 'package:simple_framework/simple_framework.dart';

class ScreenRef {
  bool firstLoad = true;

  final void Function<T extends RepositoryModel>()? _streamCallback;

  bool _validSession = true;

  ScreenRef([this._streamCallback]);

  E getEntity<E extends Entity>(E entity) {
    if (!_validSession) throw _disposedScreenRefUsedError();

    _streamCallback?.call<E>();
    return Repository().get<E>(entity);
  }

  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    if (!_validSession) throw _disposedScreenRefUsedError();

    /// If this is not the first time the Builder has run, it should not load the model again.
    /// Otherwise, a simple screen rebuild will cause another service call. We can safely get the
    /// model from the Repository knowing that it exists from the first builder call.
    ///
    /// If the ServiceModel already exists and is valid, it is returned.
    if (!firstLoad || Repository().getServiceModelStatus<M>() == ServiceModelStatus.valid) {
      return Repository().get<M>(model);
    }

    /// If the ServiceModel is loading, that means another Builder is loading it, and will send it
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

    _streamCallback?.call<M>();
    return loadedModel;
  }

  @internal
  void close() {
    _validSession = false;
  }
}

StateError _disposedScreenRefUsedError() {
  return StateError('A method was called on a ScreenRef instance which has been disposed.');
}