class Logger {
  Logger._();

  static log(String message) {
    print("MGM-APP-LOG: " + message);
  }

  static logObject(Object message) {
    log(message.toString());
  }

  static void logError(StackTrace stacktrace) {
    log("Exception occured: $stacktrace");
  }
}
