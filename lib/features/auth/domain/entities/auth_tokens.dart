import 'package:equatable/equatable.dart';

/// Authentication tokens entity
class AuthTokens extends Equatable {

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
  });
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String tokenType;

  /// Creates a copy of this auth tokens with the given fields replaced
  AuthTokens copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? tokenType,
  }) {
    return AuthTokens(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  /// Checks if the access token is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Checks if the access token will expire soon (within the given duration)
  bool willExpireSoon([Duration duration = const Duration(minutes: 5)]) {
    return DateTime.now().isAfter(expiresAt.subtract(duration));
  }

  /// Gets the time remaining until the token expires
  Duration get timeUntilExpiry {
    final now = DateTime.now();
    if (now.isAfter(expiresAt)) {
      return Duration.zero;
    }
    return expiresAt.difference(now);
  }

  /// Gets the formatted time remaining until the token expires
  String get formattedTimeUntilExpiry {
    final duration = timeUntilExpiry;
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  /// Gets the authorization header value
  String get authorizationHeader => '$tokenType $accessToken';

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    expiresAt,
    tokenType,
  ];

  @override
  String toString() {
    return 'AuthTokens(expiresAt: $expiresAt, tokenType: $tokenType)';
  }
}
