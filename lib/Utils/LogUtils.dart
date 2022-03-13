import 'package:logger/logger.dart';

var logger = Logger();

class LogUtils {
  static void log(var logMsg) {
    logger.log(Level.error,  'MyApp ===>' + logMsg);
  }
}