import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredSharedPreferences {
  final FlutterSecureStorage _secureStorage;
  SecuredSharedPreferences(this._secureStorage);

  Future<void> saveKey(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> reset() async {
    _secureStorage.deleteAll();
  }

  Future<void> saveInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<void> saveBoolean(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<int?> getInt(String key) async {
    String? value = await _secureStorage.read(key: key);
    if (value != null) {
      return int.tryParse(value);
    }
    return null;
  }

  Future<bool> getBooleans(String key) async {
    String? value = await _secureStorage.read(key: key);
    if (value != null) {
      return true.toString() == value;
    }
    return false;
  }
}
