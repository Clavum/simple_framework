import 'dart:io';

class MockClassProvider {
  MockClassProvider._();

  static final MockClassProvider _mockClassProvider = MockClassProvider._();

  final List<Object> _classes = [];

  factory MockClassProvider() {
    return _mockClassProvider;
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
