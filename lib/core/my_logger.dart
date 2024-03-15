import 'package:logger/logger.dart';

enum LoggerType { debug, info, warning, error }

class MyLogger {
  const MyLogger._();

  static Logger logger = Logger();

  static printLog(
    LoggerType type,
    String log, [
    String? message,
  ]) {
    String printMessage = '${message ?? ''} : $log';
    switch (type) {
      case LoggerType.debug:
        logger.d(printMessage);
        break;
      case LoggerType.info:
        logger.i(printMessage);
        break;
      case LoggerType.warning:
        logger.w(printMessage);
        break;
      case LoggerType.error:
        logger.e(printMessage);
        break;
    }
  }
}
