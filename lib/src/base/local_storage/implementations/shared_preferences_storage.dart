import "dart:convert";

import "package:flutter_mobile_template/src/base/local_storage/ilocal_storage.dart";
import "package:flutter_mobile_template/src/core/exceptions/exceptions.dart";
import "package:flutter_mobile_template/src/core/types/json_mapper.dart";
import "package:flutter_mobile_template/src/core/types/result_type.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesException extends LocalStorageException {
  SharedPreferencesException({
    super.message,
  }) : super(
          localStorageProvider: "SharedPreferences",
        );
}

class SharedPreferencesAsyncStorage extends ILocalStorage {
  late final SharedPreferencesAsync _storage;

  /// A map of collections to their keys.
  Map<String, List<String>> _collections = {};

  String _makeKey({
    required String collection,
    required String key,
  }) =>
      "$collection.$key";

  @override
  Future<void> init() async {
    SharedPreferences.setPrefix("uniqueAppId");
    _storage = SharedPreferencesAsync();

    await runMigrations();

    final keys = await _storage.getKeys();
    _collections = keys.fold<Map<String, List<String>>>(
      {},
      (keys, currentKey) {
        final keyParts = currentKey.split(".");
        keys[keyParts.first] = [...keys[keyParts.first] ?? [], keyParts.last];
        return keys;
      },
    );
    super.init();
  }

  @override
  Future<void> runMigrations() async {
    // No migrations needed
  }

  @override
  Future<Result<T, SharedPreferencesException>> get<T>({
    required String collection,
    required String key,
  }) async {
    final keyToGet = _makeKey(collection: collection, key: key);
    try {
      if (T.toString().contains("List")) {
        throw Exception("SharedPreferences requires to use getList method");
      }
      if (T == int || T == double || T == String || T == bool) {
        final value = await _storage.getString(keyToGet);
        if (value == null) {
          return Result.ok(data: null);
        }
        final data = jsonDecode(value);
        return Result.ok(data: data as T?);
      }

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
      }

      final value = await _storage.getString(keyToGet);
      if (value == null) {
        return Result.ok(data: null);
      }

      final data = mapper.fromJson(jsonDecode(value));
      return Result.ok(data: data);
    } catch (error) {
      return Result.error(
        error: SharedPreferencesException(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<List<T>, SharedPreferencesException>> getList<T>({
    required String collection,
    required String key,
  }) async {
    final keyToGet = _makeKey(collection: collection, key: key);
    try {
      if (T.toString().contains("List")) {
        throw Exception("SharedPreferences requires to use getList method");
      }
      if (T == int || T == double || T == String || T == bool) {
        final value = await _storage.getStringList(keyToGet);
        if (value == null) {
          return Result.ok(data: null);
        }
        final data = value.map((e) => jsonDecode(e)).toList();
        return Result.ok(data: data as List<T>?);
      }

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
      }

      final value = await _storage.getStringList(keyToGet);
      final data = value?.map((e) => mapper.fromJson(jsonDecode(e))).toList();

      return Result.ok(data: data);
    } catch (error) {
      return Result.error(
        error: SharedPreferencesException(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<bool, SharedPreferencesException>> save<T>({
    required String collection,
    required String key,
    required T value,
  }) async {
    try {
      final keyToSave = _makeKey(collection: collection, key: key);
      _collections[collection] = [..._collections[collection] ?? [], key];

      if (T.toString().contains("List")) {
        throw Exception("SharedPreferences requires to use saveList method");
      }
      if (T == int || T == double || T == String || T == bool) {
        final data = jsonEncode(value);
        await _storage.setString(keyToSave, data);
        return Result.ok(data: true);
      }

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
      }

      final data = jsonEncode(mapper.toJson(value));
      await _storage.setString(keyToSave, data);

      return Result.ok(data: true);
    } catch (error) {
      return Result.error(
        error: SharedPreferencesException(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<bool, SharedPreferencesException>> saveList<T>({
    required String collection,
    required String key,
    required List<T> value,
  }) async {
    try {
      final keyToSave = _makeKey(collection: collection, key: key);
      _collections[collection] = [..._collections[collection] ?? [], key];

      if (T.toString().contains("List")) {
        throw Exception(
          "Cannot save list of lists. Try to save a list of objects",
        );
      }
      if (T == int || T == double || T == String || T == bool) {
        final data = value.map<String>((e) => jsonEncode(e)).toList();
        await _storage.setStringList(keyToSave, data);
        return Result.ok(data: true);
      }

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
      }

      final data = value.map((e) => jsonEncode(mapper.toJson(e))).toList();
      await _storage.setStringList(keyToSave, data);

      return Result.ok(data: true);
    } catch (error) {
      return Result.error(
        error: SharedPreferencesException(
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<bool> delete({
    required String collection,
    required String key,
  }) async {
    final keyToRemove = _makeKey(collection: collection, key: key);
    await _storage.remove(keyToRemove);
    _collections[collection]?.remove(key);

    return true;
  }

  @override
  Future<bool> dropCollection({
    required String collection,
  }) async {
    _collections[collection]?.forEach(
      (key) async {
        final keyToRemove = _makeKey(collection: collection, key: key);
        await _storage.remove(keyToRemove);
      },
    );

    _collections.remove(collection);
    return true;
  }
}
