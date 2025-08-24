/// Storage key constants for the application
class AppKeys {
  // Secure storage keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  
  // Shared preferences keys
  static const String isLoggedIn = 'is_logged_in';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userDisplayName = 'user_display_name';
  static const String lastLoginTime = 'last_login_time';
  
  // Theme and settings keys
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String countryCode = 'country_code';
  
  // Cache keys
  static const String userProfileCache = 'user_profile_cache';
  static const String appSettingsCache = 'app_settings_cache';
  
  // API keys (for external services)
  static const String googleApiKey = 'google_api_key';
  static const String firebaseApiKey = 'firebase_api_key';
}
