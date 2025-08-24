import 'package:equatable/equatable.dart';

/// User entity representing a user in the system
class User extends Equatable {

  const User({
    required this.id,
    required this.email,
    required this.createdAt, this.displayName,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.lastLoginAt,
    this.metadata,
  });
  final String id;
  final String email;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? metadata;

  /// Creates a copy of this user with the given fields replaced
  User copyWith({
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
    return User(
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

  /// Gets the full name of the user
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return displayName ?? email;
  }

  /// Gets the initials of the user
  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    }
    if (displayName != null) {
      final names = displayName!.split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      }
      return names[0][0].toUpperCase();
    }
    return email[0].toUpperCase();
  }

  /// Checks if the user has a profile picture
  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  /// Checks if the user has completed their profile
  bool get hasCompleteProfile => 
      firstName != null && 
      lastName != null && 
      displayName != null;

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
    return 'User(id: $id, email: $email, displayName: $displayName)';
  }
}
