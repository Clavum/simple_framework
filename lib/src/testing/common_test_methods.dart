import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

void commonTearDown() {
  resetMocktailState();
  clearAllMocks();
}

void setupCommonFallbackValues() {
  /// Flutter & Dart.
  registerFallbackValue(const TextSelection.collapsed(offset: 0));
}

/// Takes an object, and based on its type, sets up some common default method stubs to avoid
/// errors. It is automatically used on mocks provided to the MockClassProvider, but can also be
/// used by the developer for other mocks.
void setupCommonMockStubs(Object object) {
  //TODO: Won't this remove any existing stubs? Can I check first somehow?
  if (object is Bloc) {
    when(object.onCreate).thenAnswer((_) async {});
  }
}
