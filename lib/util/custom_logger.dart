import 'package:logger/logger.dart';

class CustomLogger {
  static final logger = Logger();

  static void logInfo(String message) {
    logger.i(message);
  }

  static void logError(String message) {
    logger.e(message);
  }

  static void logWarning(String message) {
    logger.w(message);
  }

  static void logDebug(String message) {
    logger.d(message);
  }
}
