/// Environment configuration for BabylAI SDK
enum BabylAIEnvironment {
  /// Production environment
  production,

  /// Development/Testing environment
  development,
}

/// Environment configuration class that holds environment-specific settings
class EnvironmentConfig {
  final BabylAIEnvironment environment;
  final bool enableLogging;
  final int connectionTimeout;
  final int receiveTimeout;

  const EnvironmentConfig({
    required this.environment,
    this.enableLogging = true,
    this.connectionTimeout = 30000,
    this.receiveTimeout = 15000,
  });

  /// Factory constructor for production environment
  factory EnvironmentConfig.production({
    bool enableLogging = false,
    int connectionTimeout = 30000,
    int receiveTimeout = 15000,
  }) {
    return EnvironmentConfig(
      environment: BabylAIEnvironment.production,
      enableLogging: enableLogging,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

  /// Factory constructor for development/testing environment
  factory EnvironmentConfig.development({
    bool enableLogging = true,
    int connectionTimeout = 30000,
    int receiveTimeout = 15000,
  }) {
    return EnvironmentConfig(
      environment: BabylAIEnvironment.development,
      enableLogging: enableLogging,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

  /// Get the base URL based on the environment
  String get baseUrl {
    switch (environment) {
      case BabylAIEnvironment.production:
        return 'https://babylai.net/api/';
      case BabylAIEnvironment.development:
        return 'https://babylai-be.dev.kvm.creativeadvtech.ml/';
    }
  }

  /// Check if the current environment is for testing/development
  bool get isTestingMode => environment == BabylAIEnvironment.development;

  /// Check if the current environment is production
  bool get isProduction => environment == BabylAIEnvironment.production;

  /// Check if logging should be enabled
  bool get shouldEnableLogging => enableLogging;

  @override
  String toString() {
    return 'EnvironmentConfig(environment: $environment, baseUrl: $baseUrl, enableLogging: $enableLogging)';
  }
}
