import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

void commonTearDown() {
  if (Repository() is RepositoryMock) {
    reset(Repository());
  }
  resetMocktailState();
  MockClassProvider().clear();
  clearAllMocks();
}

void setupCommonFallbackValues() {
  /// Flutter & Dart.
  registerFallbackValue(const TextSelection.collapsed(offset: 0));

  /// Framework.
  registerFallbackValue(ScreenRef(<T extends RepositoryModel>() {}));
}

/// Takes an object, and based on its type, sets up some common default method stubs to avoid
/// errors. It is automatically used on mocks provided to the MockClassProvider, but can also be
/// used by the developer for other mocks.
void setupCommonMockStubs(Object object) {
  if (object is Bloc) {
    when(object.onCreate).thenAnswer((_) async {});
  }
}
