import 'package:shared_preferences/shared_preferences.dart';

/// Interface for key-value storage operations
abstract class KeyValueStore {
  /// Stores a boolean value with the given key
  Future<void> setBool(String key, {required bool value});

  /// Stores an integer value with the given key
  Future<void> setInt(String key, {required int value});

  /// Stores a double value with the given key
  Future<void> setDouble(String key, {required double value});

  /// Stores a list of strings with the given key
  Future<void> setStringList(String key, {required List<String> value});

  /// Stores a string value with the given key
  Future<void> setString(String key, {required String value});

  /// Retrieves a string value with the given key
  String? getString(String key);

  /// Retrieves a boolean value with the given key
  bool? getBool(String key);

  /// Retrieves an integer value with the given key
  int? getInt(String key);

  /// Retrieves a double value with the given key
  double? getDouble(String key);

  /// Retrieves a list of strings with the given key
  List<String>? getStringList(String key);

  /// Deletes a value with the given key
  Future<void> remove(String key);

  /// Deletes all stored values
  Future<void> clear();

  /// Checks if a key exists
  bool containsKey(String key);

  /// Gets all keys
  Set<String> getKeys();
}

/// Implementation of key-value store using SharedPreferences
class KeyValueStoreImpl implements KeyValueStore {
  const KeyValueStoreImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<void> setString(String key, {required String value}) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> setBool(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> setInt(String key, {required int value}) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> setDouble(String key, {required double value}) async {
    await _prefs.setDouble(key, value);
  }

  @override
  Future<void> setStringList(String key, {required List<String> value}) async {
    await _prefs.setStringList(key, value);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  @override
  Set<String> getKeys() {
    return _prefs.getKeys();
  }
}
