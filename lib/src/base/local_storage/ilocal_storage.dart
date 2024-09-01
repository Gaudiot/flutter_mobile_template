abstract class ILocalStorage {
  Future<void> init();
  Future<bool> save<T>({String collection, String key, T value});
  Future<T?> get<T>({String collection, String key});
  Future<bool> delete({String collection, String key});
  Future<bool> dropCollection({String collection});
}
