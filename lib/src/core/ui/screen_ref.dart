import 'package:simple_framework/simple_framework.dart';

class ScreenRef {
  void Function<T extends RepositoryModel>()? streamCallback;

  ScreenRef(this.streamCallback);

  E getEntity<E extends Entity>(E entity) {
    if (streamCallback != null) {
      streamCallback!<E>();
    }
    return Repository().get<E>(entity);
  }

  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    if (Repository().getServiceModelStatus<M>() == ServiceModelStatus.valid) {
      return Repository().get<M>(model);
    }
    //TODO: if state is loading, what should I do?
    Repository().setServiceModelStatus<M>(ServiceModelStatus.loading);

    M loadedModel;
    try {
      loadedModel = await model.load() as M;
    } on TypeError {
      Repository().setServiceModelStatus<M>(ServiceModelStatus.invalid);
      throw ArgumentError('The load method for $M returned a Model of a type other than itself.');
    }
    Repository().setServiceModelStatus<M>(ServiceModelStatus.valid);

    loadedModel.send();
    if (streamCallback != null) {
      streamCallback!<M>();
    }
    return loadedModel;
  }

  void close() {
    streamCallback = null;
  }
}
