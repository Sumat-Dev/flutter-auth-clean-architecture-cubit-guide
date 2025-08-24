import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interface for secure storage operations
abstract class SecureStorage {
  /// Stores a value securely with the given key
  Future<void> write(String key, String value);
  
  /// Retrieves a value securely with the given key
  Future<String?> read(String key);
  
  /// Deletes a value securely with the given key
  Future<void> delete(String key);
  
  /// Deletes all stored values
  Future<void> deleteAll();
  
  /// Checks if a key exists
  Future<bool> containsKey(String key);
}

/// Implementation of secure storage using flutter_secure_storage
class SecureStorageImpl implements SecureStorage {
  
  const SecureStorageImpl({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage();
  final FlutterSecureStorage _storage;
  
  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  @override
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }
  
  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
  
  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key: key);
  }
}
