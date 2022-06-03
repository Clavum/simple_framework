import 'package:simple_framework/simple_framework.dart';

class ScreenRef {
  late bool firstLoad;

  void Function<T extends RepositoryModel>()? streamCallback;

  ScreenRef(this.streamCallback) {
    firstLoad = true;
  }

  E getEntity<E extends Entity>(E entity) {
    if (streamCallback != null) {
      streamCallback!<E>();
    }
    return Repository().get<E>(entity);
  }

  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    if (!firstLoad || Repository().getServiceModelStatus<M>() == ServiceModelStatus.valid) {
      return Repository().get<M>(model);
    }
    //TODO: if state is loading, what should I do? At this point it just loads it too.
    //
    // Build needs to be synchronous, and just return an object indicating it's loading(?)
    // Basically assume all the time that it's going to be loading, build loading screen, subscribe
    // to service model updates, and then it'll rebuild and not be loading. Not sure this works.

    // Make builders have a different method just for loading service models, it doesn't have to
    // return anything. Wait for this first, then call build, which will get the loaded models.
    // I don't like how it makes it harder for users though, needed to be sure to list them all.
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
