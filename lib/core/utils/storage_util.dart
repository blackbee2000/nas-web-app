import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nasmobile/core/enums/language_mode.dart';

class _StorageKey {
  _StorageKey._();

  static const String intro = 'intro';
  static const String token = 'token';
  static const String language = 'language';
}

class StorageUtil {
  StorageUtil._();

  static final StorageUtil _instance = StorageUtil._();

  static StorageUtil get instance => _instance;

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Write token
  Future<void> writeToken(String token) async {
    await _storage.write(
      key: _StorageKey.token,
      value: token,
    );
  }

  /// Delete token
  Future<void> deleteToken() async {
    await _storage.delete(
      key: _StorageKey.token,
    );
  }

  /// Read token
  Future<String?> readToken() async {
    return await _storage.read(
      key: _StorageKey.token,
    );
  }

  /// Write language
  Future<void> writeLanguage(LanguageMode language) async {
    await _storage.write(
      key: _StorageKey.language,
      value: language.shortName,
    );
  }

  /// Delete language
  Future<void> deleteLanguage() async {
    await _storage.delete(
      key: _StorageKey.language,
    );
  }

  /// Read language
  Future<LanguageMode> readLanguage() async {
    return LanguageMode.mapping(await _storage.read(
      key: _StorageKey.language,
    ));
  }

  /// Read intro
  Future<String?> readIntro() async {
    return await _storage.read(
      key: _StorageKey.intro,
    );
  }

  /// Write intro
  Future<void> writeIntro() async {
    await _storage.write(
      key: _StorageKey.intro,
      value: 'First Run',
    );
  }

  /// Delete intro
  Future<void> deleteIntro() async {
    await _storage.delete(
      key: _StorageKey.intro,
    );
  }

  /// Delete all data
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Clear all storage except some value
  Future<void> clearAllStorageExceptValue() async {
    /// Value need save no clear

    /// Clear all storage
    await deleteAll();

    /// Write value
    await writeIntro();
  }
}
