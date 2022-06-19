import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

void setupCommonFallbackValues() {
  registerFallbackValue(const TextSelection.collapsed(offset: 0));
}
