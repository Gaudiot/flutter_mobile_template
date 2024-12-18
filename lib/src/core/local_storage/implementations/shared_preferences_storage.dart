import "dart:convert";

import "package:flutter_mobile_template/src/core/exceptions/exceptions.dart";
import "package:flutter_mobile_template/src/core/local_storage/ilocal_storage.dart";
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
  final SharedPreferencesAsync _storage = SharedPreferencesAsync();

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

    await runMigrations();

    final keys = await _storage.getKeys();
    _collections = keys.fold<Map<String, List<String>>>(
      {},
      (keys, currentKey) {
        final keyParts = currentKey.split(".");
        if (keys[keyParts.first]?.isEmpty ?? true) {
          keys[keyParts.first] = [];
        }
        keys[keyParts.first] = [...keys[keyParts.first]!, keyParts.last];
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
  Future<Result<bool, SharedPreferencesException>> hasKey({
    required String collection,
    required String key,
  }) async {
    final keyToGet = _makeKey(collection: collection, key: key);
    return Result.ok(data: await _storage.containsKey(keyToGet));
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
      final value = await _storage.getString(keyToGet);
      if (value == null) return Result.ok(data: null);
      if (T == int || T == double || T == String || T == bool) {
        final data = jsonDecode(value);
        return Result.ok(data: data as T?);
      }

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
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
  Future<Result<List<T>, SharedPreferencesException>> getAllFromCollection<T>({
    required String collection,
  }) async {
    try {
      final keys = _collections[collection] ?? [];
      final List<T> result = [];

      for (final key in keys) {
        final keyToGet = _makeKey(collection: collection, key: key);
        final value = await _storage.getString(keyToGet);

        if (value != null) {
          if (T == int || T == double || T == String || T == bool) {
            final data = jsonDecode(value);
            result.add(data as T);
          } else {
            final mapper = MapperRegistry.get<T>();
            if (mapper == null) {
              throw Exception("Mapper para o tipo $T não encontrado");
            }

            final data = mapper.fromJson(jsonDecode(value));
            result.add(data);
          }
        }
      }

      return Result.ok(data: result);
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
      final keyExists = await hasKey(collection: collection, key: key);
      if (keyExists.hasData && !keyExists.data!) {
        _collections[collection] = [..._collections[collection] ?? [], key];
      }

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
