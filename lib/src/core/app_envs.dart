import "package:flutter_dotenv/flutter_dotenv.dart";

class AppEnvs {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String get(String key) {
    return dotenv.env[key] ?? "";
  }
}
