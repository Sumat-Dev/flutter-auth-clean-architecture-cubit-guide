/// Environment configuration for the application
class Env {
  /// Current environment
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// API base URL
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  /// API version
  static const String apiVersion = String.fromEnvironment(
    'API_VERSION',
    defaultValue: 'v1',
  );

  /// App name
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Clean Architecture Guide',
  );

  /// App version
  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );

  /// Build number
  static const String buildNumber = String.fromEnvironment(
    'BUILD_NUMBER',
    defaultValue: '1',
  );

  /// Whether to enable logging
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  /// Whether to enable analytics
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
  );

  /// Whether to enable crash reporting
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
  );

  /// Connection timeout in seconds
  static const int connectionTimeout = int.fromEnvironment(
    'CONNECTION_TIMEOUT',
    defaultValue: 30,
  );

  /// Receive timeout in seconds
  static const int receiveTimeout = int.fromEnvironment(
    'RECEIVE_TIMEOUT',
    defaultValue: 30,
  );

  /// Send timeout in seconds
  static const int sendTimeout = int.fromEnvironment(
    'SEND_TIMEOUT',
    defaultValue: 30,
  );

  /// Helper getters
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'production';

  static String get fullApiUrl => '$apiBaseUrl/$apiVersion';

  /// Get timeout duration
  static Duration get connectionTimeoutDuration =>
      const Duration(seconds: connectionTimeout);
  static Duration get receiveTimeoutDuration =>
      const Duration(seconds: receiveTimeout);
  static Duration get sendTimeoutDuration =>
      const Duration(seconds: sendTimeout);
}
