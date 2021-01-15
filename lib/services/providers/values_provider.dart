import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/value.dart';
import '../values_api.dart';

/// This provider is used to hold all available values.
class ValuesProvider extends ChangeNotifier {
  ValuesProvider([List<Value> mockupValues]) : _values = mockupValues ?? [];

  List<Value> _values;

  List<Value> get values => _values;

  // Returns true if the values collection contains an element with id equal
  // to [id].
  bool contains(String id) => _values.where((e) => e.id == id).isNotEmpty;

  /// Get value by its id
  Value valueById(String id) => _values.firstWhere((e) => e.id == id);

  /// Clear all the values before loading new from device storage
  void clear() {
    _values = [];
  }

  /// Load initial values from api
  void setUp(Iterable<Value> initialValues) => _values.addAll(initialValues);

  /// Adds value to storage
  Future add({
    @required String text,
  }) async {
    String id = nextId;

    _values.add(Value(
      id: id,
      text: text,
    ));

    await _saveToStorage();

    notifyListeners();
  }

  /// Remove value from storage. Corresponding favorite if exists should be
  /// removed manually.
  Future remove(String id) async {
    _values.removeWhere((e) => e.id == id);

    await _saveToStorage();

    notifyListeners();
  }

  /// Saves non-core values serialized as JSON to device storage.
  Future _saveToStorage() async {
    // Do not save to device storage while running unit tests
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setStringList(
      'custom_values',
      _values
          .where((e) => e.canBeDeleted)
          .map((e) => jsonEncode(e.toJson()))
          .toList(),
    );
  }
}

/// Unique id generator
String get nextId => _uuid.v1();

/// Uuid instance used to generate ids
Uuid _uuid = Uuid();

/// Initial loading of all values from REST api and saved in device storage
///
/// [offline] is used mainly for unit testing.
Future loadValues(BuildContext context, {bool offline = false}) async {
  // Load Seven Core Values From Api
  List<Value> coreValues = offline ? [] : await getCoreValues();

  // Load saved custom values

  SharedPreferences preferences = await SharedPreferences.getInstance();

  List<String> savedJsonValues =
      preferences.getStringList('custom_values') ?? [];

  Iterable<Value> savedCustomValues =
      savedJsonValues.map((e) => Value.fromJson(jsonDecode(e)));

  Provider.of<ValuesProvider>(context, listen: false)
    ..clear()
    ..setUp(coreValues)
    ..setUp(savedCustomValues);
}
