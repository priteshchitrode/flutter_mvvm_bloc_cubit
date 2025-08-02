import 'environment_variable.dart';

/// Controls the current environment setting
abstract class EnvironmentController {
  static const int DEV = 0;
  static const int PROD = 2;

  /// Set the current environment here
  static int get currentEnv => DEV;
// static int get currentEnv => PROD;
}
