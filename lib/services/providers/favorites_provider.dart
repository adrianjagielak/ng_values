import 'package:flutter/material.dart';

/// This provider is used to hold user favorite values.
class FavoritesProvider extends ChangeNotifier {
  List<int> _favoritesIds = [];

  List<int> get favoritesIds => _favoritesIds;

  set favoritesIds(List<int> ids) {
    _favoritesIds = ids;
    notifyListeners();
  }

  /// Clear all the favorites before loading new from device storage
  void clear() {
    _favoritesIds = [];
  }

  /// Load initial values from device storage
  void setUp(Iterable<int> initialValues) =>
      _favoritesIds.addAll(initialValues);

  /// Adds value id to favorites
  void add(int newFavorite) {
    if (!_favoritesIds.contains(newFavorite)) {
      _favoritesIds.add(newFavorite);
      notifyListeners();
    }
  }

  /// Remove value id from favorites
  void remove(int favorite) {
    if (_favoritesIds.contains(favorite)) {
      _favoritesIds.remove(favorite);
      notifyListeners();
    }
  }
}
