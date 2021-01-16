import 'dart:math';

/// Instance of [Random]
Random _random = Random();

extension ListRandom<T> on List<T> {
  // Returns random element.
  T get random => this[_random.nextInt(length)];
}
