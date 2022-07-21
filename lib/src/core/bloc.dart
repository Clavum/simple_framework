import 'dart:async';

import 'package:simple_framework/src/core/models/view_model.dart';
import 'package:simple_framework/src/core/ui/screen_ref.dart';

abstract class Bloc<V extends ViewModel> {
  /// Optional method to override, to trigger events when the Screen (and Bloc) are first created.
  /// The return type is `Future<bool?>` because the Screen will show the loading screen until the
  /// Future is complete. You can also optionally return `false` to show the error screen.
  Future<void> onCreate() async {}

  FutureOr<V> buildViewModel(ScreenRef ref);

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void dispose() {}
}
