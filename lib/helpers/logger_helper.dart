class LoggerHelper {
  static void logInfo(String function, String message) {
    print("$function -> $message");
  }

  static void logError(String message) {
    print(message);
  }
}
