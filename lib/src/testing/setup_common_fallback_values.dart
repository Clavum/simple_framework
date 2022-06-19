import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_framework/simple_framework.dart';

void setupCommonFallbackValues() {
  /// Flutter & Dart.
  registerFallbackValue(const TextSelection.collapsed(offset: 0));

  /// Framework.
  registerFallbackValue(ScreenRef(<T extends RepositoryModel>() {}));
}
