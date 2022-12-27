part of 'core.dart';

abstract class Bloc<V extends ViewModel> {
  // Set by the ScreenState.
  late ScreenState _screenState;
  BuildContext? _mockContext;

  BuildContext get context => _mockContext ?? _screenState.context;

  /// If creating a bloc for unit tests, you'll need to use this to provide a mock context.
  @visibleForTesting
  set context(BuildContext value) => _mockContext = value;

  /// Optional method to override, to trigger events when the [Bloc] is first created by a [Screen].
  /// If your onCreate method is asynchronous, the [Screen] will display its loading screen until
  /// the method completes.
  FutureOr<void> onCreate() async {}

  FutureOr<V> buildViewModel();

  /// By default, the [Bloc] will only send a new [ViewModel] if it has changed. You can override
  /// this method to customize the behavior.
  bool shouldSendNewModel(V? currentViewModel, V newViewModel) => currentViewModel != newViewModel;

  /// Optional method to override, to trigger events when the Screen (and Bloc) are disposed.
  void onDispose() {}
}
