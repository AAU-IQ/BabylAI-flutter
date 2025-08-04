import 'environment_config.dart';

/// Service to manage environment configuration for BabylAI SDK
class EnvironmentService {
  static EnvironmentConfig? _config;

  /// Initialize the environment configuration
  static void initialize(EnvironmentConfig config) {
    _config = config;
  }

  /// Get the current environment configuration
  /// Throws an exception if not initialized
  static EnvironmentConfig get config {
    if (_config == null) {
      throw Exception('Environment configuration not initialized. '
          'Please call BabylAI.initialize() with proper environment configuration before using the SDK.');
    }
    return _config!;
  }

  /// Check if the environment service is initialized
  static bool get isInitialized => _config != null;

  /// Get the base URL for API calls
  static String get baseUrl => config.baseUrl;

  /// Check if logging should be enabled
  static bool get shouldEnableLogging => config.shouldEnableLogging;

  /// Check if the current environment is for testing
  static bool get isTestingMode => config.isTestingMode;

  /// Check if the current environment is production
  static bool get isProduction => config.isProduction;

  /// Get connection timeout
  static int get connectionTimeout => config.connectionTimeout;

  /// Get receive timeout
  static int get receiveTimeout => config.receiveTimeout;

  /// Reset the environment configuration (mainly for testing purposes)
  static void reset() {
    _config = null;
  }
}
