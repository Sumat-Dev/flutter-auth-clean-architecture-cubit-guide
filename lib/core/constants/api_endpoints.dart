/// API endpoint constants
class ApiEndpoints {
  // Base URLs
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );
  
  static const String apiVersion = '/v1';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  
  // User endpoints
  static const String users = '/users';
  static const String profile = '/users/profile';
  
  // Helper methods
  static String get fullBaseUrl => '$baseUrl$apiVersion';
  
  static String get fullLoginUrl => '$fullBaseUrl$login';
  static String get fullRegisterUrl => '$fullBaseUrl$register';
  static String get fullRefreshUrl => '$fullBaseUrl$refresh';
  static String get fullLogoutUrl => '$fullBaseUrl$logout';
  static String get fullMeUrl => '$fullBaseUrl$me';
  static String get fullUsersUrl => '$fullBaseUrl$users';
  static String get fullProfileUrl => '$fullBaseUrl$profile';
}
