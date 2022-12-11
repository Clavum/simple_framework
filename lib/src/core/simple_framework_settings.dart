part of 'core.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
}

class SimpleFrameworkSettings {
  static void Function(LogLevel level, String message) onLog = (_, message) {
    debugPrint(message);
  };
}
