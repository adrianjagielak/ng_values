import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This provider is used to hold user favorite values.
class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider([List<String> mockupFavorites])
      : _favoritesIds = mockupFavorites ?? [];

  List<String> _favoritesIds;

  List<String> get favoritesIds => _favoritesIds;

  set favoritesIds(List<String> ids) {
    _favoritesIds = ids;
    notifyListeners();
  }

  /// Clear all the favorites before loading new from device storage
  void clear() {
    _favoritesIds = [];
  }

  /// Load initial values from device storage
  void setUp(Iterable<String> initialValues) =>
      _favoritesIds.addAll(initialValues);

  /// Adds value id to favorites
  Future add(String newFavorite) async {
    if (!_favoritesIds.contains(newFavorite)) {
      _favoritesIds.add(newFavorite);

      await _saveToStorage();

      notifyListeners();
    }
  }

  /// Remove value id from favorites
  Future remove(String favorite) async {
    if (_favoritesIds.contains(favorite)) {
      _favoritesIds.remove(favorite);

      await _saveToStorage();

      notifyListeners();
    }
  }

  /// Saves favorites ids to device storage.
  Future _saveToStorage() async {
    // Do not save to device storage while running unit tests
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setStringList('favorites', _favoritesIds);
  }
}

/// Initial loading of saved favorites from device storage
Future loadSavedFavorites(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // SharedPreferences only allow to save list of string so we will need to
  // parse them to ints
  List<String> ids = preferences.getStringList('favorites') ?? [];

  Provider.of<FavoritesProvider>(context, listen: false)
    ..clear()
    ..setUp(ids);
}
