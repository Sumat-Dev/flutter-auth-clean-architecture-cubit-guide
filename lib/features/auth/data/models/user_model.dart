import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User model for data layer
@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    this.id,
    this.email,
    this.createdAt,
    this.displayName,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.lastLoginAt,
    this.metadata,
  });

  /// Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Creates a UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
      firstName: user.firstName,
      lastName: user.lastName,
      avatarUrl: user.avatarUrl,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      lastLoginAt: user.lastLoginAt,
      metadata: user.metadata,
    );
  }
  final String? id;
  final String? email;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  @JsonKey(name: 'is_email_verified')
  final bool isEmailVerified;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? metadata;

  /// Converts UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Converts UserModel to User entity
  User toEntity() {
    return User(
      id: id ?? '',
      email: email ?? '',
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      avatarUrl: avatarUrl,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt ?? DateTime.now(),
      lastLoginAt: lastLoginAt,
      metadata: metadata,
    );
  }

  /// Creates a copy of this UserModel with the given fields replaced
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? metadata,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    firstName,
    lastName,
    avatarUrl,
    isEmailVerified,
    createdAt,
    lastLoginAt,
    metadata,
  ];

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName)';
  }
}
