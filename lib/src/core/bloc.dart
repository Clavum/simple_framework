abstract class Bloc {
  /// Optional method to override, to trigger events when the Screen (and Bloc) are first created.
  void onCreate() {}

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void dispose() {}
}
