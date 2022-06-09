abstract class Bloc {
  /// Optional method to override, to trigger events when the Screen (and Bloc) are first created.
  /// The return type is `Future<bool?>` because the Screen will show the loading screen until the
  /// Future is complete. You can also optionally return `false` to show the error screen.
  Future<void> onCreate() async {}

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void dispose() {}
}

class EmptyBloc extends Bloc {}