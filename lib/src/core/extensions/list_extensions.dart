extension ListExtensions<T> on List<T> {
  List<U> mapIndexed<U>(U Function(int index, T) transformer) {
    final newCollection = List<U>.empty(growable: true);

    int i = 0;
    for (final item in this) {
      newCollection.add(transformer(i, item));
      i++;
    }
    return newCollection;
  }
}
