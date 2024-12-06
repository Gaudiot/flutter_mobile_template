import "package:flutter_mobile_template/src/base/local_storage/local_storage_exception.dart";
import "package:flutter_mobile_template/src/core/types/result_type.dart";

abstract class ILocalStorage {
  Future<void> init() async {
    await runMigrations();
  }

  Future<void> runMigrations();
  Future<Result<bool, LocalStorageException>> save<T>({
    required String collection,
    required String key,
    required T value,
  });
  Future<Result<T, LocalStorageException>> get<T>({
    required String collection,
    required String key,
  });
  Future<Result<List<T>, LocalStorageException>> getAllFromCollection<T>({
    required String collection,
  });
  Future<bool> delete({
    required String collection,
    required String key,
  });
  Future<bool> dropCollection({
    required String collection,
  });

  Future<Result<bool, LocalStorageException>> hasKey({
    required String collection,
    required String key,
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
