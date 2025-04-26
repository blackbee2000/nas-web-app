import 'package:logger/logger.dart';

class LogUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 200, // width of the output
      colors: true, // Colorful log messages
      printEmojis: false, // Print an emoji for each log message
    ),
  );

  LogUtil._();

  /// Log debug
  static void logDebug(dynamic message) {
    _logger.d(message);
  }

  /// Log info
  static void logInfo(dynamic message) {
    _logger.i(message);
  }

  /// Log error
  static void logError(dynamic message) {
    _logger.e(message);
  }

  /// Log warning
  static void logWarning(dynamic message) {
    _logger.w(message);
  }
}
