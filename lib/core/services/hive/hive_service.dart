import 'package:hive_flutter/hive_flutter.dart';

/// Low-level Hive service for generic key-value storage operations
/// Similar to DioManager for HTTP requests, this manages Hive database operations
class HiveService {
  static const String _boxName = 'appBox';
  Box<dynamic>? _box;

  // Singleton pattern
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  /// Initialize Hive box - must be called before any operations
  Future<void> init() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox(_boxName);
    }
  }

  /// Get the box instance
  /// Throws exception if not initialized
  Box<dynamic> get _getBox {
    if (_box == null) {
      throw Exception(
        "HiveService: Box not initialized. Please call init() first.",
      );
    }
    return _box!;
  }

  /// Get a value by key
  T? get<T>(String key, {T? defaultValue}) {
    return _getBox.get(key, defaultValue: defaultValue) as T?;
  }

  /// Set a value for a key
  Future<void> put(String key, dynamic value) async {
    await _getBox.put(key, value);
  }

  /// Delete a value by key
  Future<void> delete(String key) async {
    await _getBox.delete(key);
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _getBox.containsKey(key);
  }

  /// Clear all data from box
  Future<void> clear() async {
    await _getBox.clear();
  }

  /// Get all keys
  Iterable<dynamic> get keys => _getBox.keys;

  /// Close the box
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}
