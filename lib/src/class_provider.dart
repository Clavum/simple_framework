import 'dart:io';

class ClassProvider {
  ClassProvider._();

  static final ClassProvider _classProvider = ClassProvider._();

  final List<dynamic> _classes = [];

  factory ClassProvider() {
    return _classProvider;
  }

  E get<E extends Object, M extends Object>(
      {required E real, required M mock, bool allowMock = true}) {
    return _classes.firstWhere((object) => object.runtimeType == E || object.runtimeType == M,
        orElse: () {
      if (Platform.environment.containsKey('FLUTTER_TEST') && allowMock) {
        _classes.add(mock);
        return mock;
      } else {
        _classes.add(real);
        return real;
      }
    }) as E;
  }
}
