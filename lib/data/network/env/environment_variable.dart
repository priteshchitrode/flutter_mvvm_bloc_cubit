import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvvm_bloc_cubit/data/network/env/environment_controller.dart';

class EnvironmentVariables {
  static String get fetchBaseUrl {
    // final devBaseUrl = dotenv.env["API_BASE_URL_LOCALHOST_FOR_ANDROID"] ?? "";
    // final prodBaseUrl = dotenv.env["API_BASE_URL_PROD"] ?? "";

    final devBaseUrl = dotenv.env["API_BASE_URL"] ?? "";
    final prodBaseUrl = dotenv.env["API_BASE_URL"] ?? "";
    final port = dotenv.env["PORT"] ?? "";

    switch (EnvironmentController.currentEnv) {
      case EnvironmentController.DEV:
        return _formatBaseUrl(devBaseUrl, port);
      case EnvironmentController.PROD:
        return _formatBaseUrl(prodBaseUrl, port);
      default:
        throw Exception("Failed to fetch base URL: Unknown environment");
    }
  }

  static String get fetchApiBasicAuthUsername {
    return _getEnvVariable("API_BASIC_AUTH_USERNAME");
  }

  static String get fetchApiBasicAuthPassword {
    return _getEnvVariable("API_BASIC_AUTH_PASSWORD");
  }

  // Helper method to fetch environment variables safely
  static String _getEnvVariable(String key) {
    final devValue = dotenv.env[key] ?? "";
    final prodValue = dotenv.env[key] ?? "";

    switch (EnvironmentController.currentEnv) {
      case EnvironmentController.DEV:
        return devValue.isNotEmpty ? devValue : throw Exception("$key not found in .env for DEV");
      case EnvironmentController.PROD:
        return prodValue.isNotEmpty ? prodValue : throw Exception("$key not found in .env for PROD");
      default:
        throw Exception("Failed to fetch $key: Unknown environment");
    }
  }

  // Helper method to construct base URL with port
  static String _formatBaseUrl(String baseUrl, String port) {
    if (baseUrl.isEmpty) {
      throw Exception("Base URL is empty");
    }
    return port.isNotEmpty ? "$baseUrl$port" : baseUrl;
  }
}
