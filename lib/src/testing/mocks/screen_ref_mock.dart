import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

class ScreenRefMock extends Mock implements ScreenRef {
  @override
  E getEntity<E extends Entity>(E entity) {
    return Repository().get<E>(entity);
  }

  @override
  Future<M> getServiceModel<M extends ServiceModel>(M model) async {
    return Repository().get<M>(model);
  }
}
