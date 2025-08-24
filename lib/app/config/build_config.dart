import 'package:flutter_clean_architecture_cubit_guide/app/config/env.dart';

/// Build configuration for the application
class BuildConfig {
  /// Whether this is a debug build
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;

  /// Whether this is a profile build
  static const bool isProfile = bool.fromEnvironment('dart.vm.profile') == true;

  /// Whether this is a release build
  static const bool isRelease = bool.fromEnvironment('dart.vm.product') == true;

  /// Whether to enable debug features
  static bool get enableDebugFeatures => isDebug || Env.isDevelopment;

  /// Whether to enable profile features
  static bool get enableProfileFeatures => isProfile || Env.isStaging;

  /// Whether to enable release features
  static bool get enableReleaseFeatures => isRelease || Env.isProduction;

  /// Whether to show debug banner
  static bool get showDebugBanner => enableDebugFeatures;

  /// Whether to enable logging
  static bool get enableLogging =>
      Env.enableLogging && (enableDebugFeatures || enableProfileFeatures);

  /// Whether to enable analytics
  static bool get enableAnalytics =>
      Env.enableAnalytics && enableReleaseFeatures;

  /// Whether to enable crash reporting
  static bool get enableCrashReporting =>
      Env.enableCrashReporting && enableReleaseFeatures;

  /// Whether to enable performance monitoring
  static bool get enablePerformanceMonitoring =>
      enableProfileFeatures || enableReleaseFeatures;

  /// Whether to enable error reporting
  static bool get enableErrorReporting => enableReleaseFeatures;

  /// Whether to enable network logging
  static bool get enableNetworkLogging => enableDebugFeatures;

  /// Whether to enable storage logging
  static bool get enableStorageLogging => enableDebugFeatures;

  /// Whether to enable state logging
  static bool get enableStateLogging => enableDebugFeatures;

  /// Whether to enable route logging
  static bool get enableRouteLogging => enableDebugFeatures;

  /// Whether to enable dependency injection logging
  static bool get enableDILogging => enableDebugFeatures;

  /// Whether to enable validation logging
  static bool get enableValidationLogging => enableDebugFeatures;

  /// Whether to enable cache logging
  static bool get enableCacheLogging => enableDebugFeatures;

  /// Whether to enable interceptor logging
  static bool get enableInterceptorLogging => enableDebugFeatures;

  /// Whether to enable repository logging
  static bool get enableRepositoryLogging => enableDebugFeatures;

  /// Whether to enable use case logging
  static bool get enableUseCaseLogging => enableDebugFeatures;

  /// Whether to enable cubit logging
  static bool get enableCubitLogging => enableDebugFeatures;

  /// Whether to enable page logging
  static bool get enablePageLogging => enableDebugFeatures;

  /// Whether to enable widget logging
  static bool get enableWidgetLogging => enableDebugFeatures;

  /// Whether to enable form logging
  static bool get enableFormLogging => enableDebugFeatures;

  /// Whether to enable button logging
  static bool get enableButtonLogging => enableDebugFeatures;

  /// Whether to enable text field logging
  static bool get enableTextFieldLogging => enableDebugFeatures;

  /// Whether to enable loading indicator logging
  static bool get enableLoadingIndicatorLogging => enableDebugFeatures;

  /// Whether to enable theme logging
  static bool get enableThemeLogging => enableDebugFeatures;

  /// Whether to enable localization logging
  static bool get enableLocalizationLogging => enableDebugFeatures;
}
