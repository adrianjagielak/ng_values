import 'package:flutter/material.dart';

import '../../models/value.dart';

/// This provider is used to hold all available values.
class ValuesProvider extends ChangeNotifier {
  ValuesProvider([List<Value> mockupValues])
      : _values = mockupValues ?? [];

  List<Value> _values;

  List<Value> get values => _values;

  /// Get value by its id
  Value valueById(int id) => _values.firstWhere((e) => e.id == id);

  /// Clear all the values before loading new from device storage
  void clear() {
    _values = [];
  }

  /// Load initial values from api
  void setUp(Iterable<Value> initialValues) => _values.addAll(initialValues);

  /// Adds value to storage
  void add({
    @required String text,
  }) {
    int id = nextId;

    _values.add(Value(
      id: id,
      text: text,
    ));

    notifyListeners();
  }

  /// Remove value from storage
  void remove(int id) {
    _values.removeWhere((e) => e.id == id);

    notifyListeners();
  }
}

/// Unique incremental id generator
int get nextId => _ids++;

/// Global number used to generate ids
int _ids = 0;
