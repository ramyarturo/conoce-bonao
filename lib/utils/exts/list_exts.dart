extension ListX<T> on Iterable<T> {
 
  T? firstOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }
}

