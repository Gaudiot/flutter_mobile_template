import "package:flutter_mobile_template/src/core/types/result_type.dart";

abstract class ILocalStorage {
  Future<void> init() async {
    await runMigrations();
  }

  Future<void> runMigrations();
  Future<Result<bool, Exception>> save<T>({
    required String collection,
    required String key,
    required T value,
  });
  Future<Result<bool, Exception>> saveList<T>({
    required String collection,
    required String key,
    required List<T> value,
  });
  Future<Result<T, Exception>> get<T>({
    required String collection,
    required String key,
  });
  Future<Result<List<T>, Exception>> getList<T>({
    required String collection,
    required String key,
  });
  Future<bool> delete({
    required String collection,
    required String key,
  });
  Future<bool> dropCollection({
    required String collection,
  });
}

abstract class ILocalStorageCollection {
  Future<bool> save<T>({
    required String key,
    required T value,
  });
  Future<T?> get<T>({
    required String key,
  });
  Future<bool> delete({
    required String key,
  });
}
