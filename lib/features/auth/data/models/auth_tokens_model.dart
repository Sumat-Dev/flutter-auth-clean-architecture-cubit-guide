import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/auth_tokens.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens_model.g.dart';

/// Auth tokens model for data layer
@JsonSerializable()
class AuthTokensModel extends Equatable {
  const AuthTokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
  });

  /// Creates an AuthTokensModel from JSON
  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

  /// Creates an AuthTokensModel from AuthTokens entity
  factory AuthTokensModel.fromEntity(AuthTokens tokens) {
    return AuthTokensModel(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiresAt: tokens.expiresAt,
      tokenType: tokens.tokenType,
    );
  }
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  @JsonKey(name: 'token_type')
  final String tokenType;

  /// Converts AuthTokensModel to JSON
  Map<String, dynamic> toJson() => _$AuthTokensModelToJson(this);

  /// Converts AuthTokensModel to AuthTokens entity
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      tokenType: tokenType,
    );
  }

  /// Creates a copy of this AuthTokensModel with the given fields replaced
  AuthTokensModel copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? tokenType,
  }) {
    return AuthTokensModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    expiresAt,
    tokenType,
  ];

  @override
  String toString() {
    return 'AuthTokensModel(expiresAt: $expiresAt, tokenType: $tokenType)';
  }
}
