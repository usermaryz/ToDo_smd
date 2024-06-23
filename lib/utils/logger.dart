import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void d(String message) {
    if (!kReleaseMode) {
      _logger.d(message);
    }
  }

  static void e(String message, {dynamic error, StackTrace? stackTrace}) {
    if (!kReleaseMode) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  static void i(String message) {
    if (!kReleaseMode) {
      _logger.i(message);
    }
  }

  static void w(String message) {
    if (!kReleaseMode) {
      _logger.w(message);
    }
  }
}
