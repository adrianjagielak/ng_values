import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/services/providers/values_provider.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ValuesProvider', () {
    testWidgets('load values from device storage', (WidgetTester tester) async {
      List<Value> customValues = [
        Value(id: '10', text: 'Value 10!'),
        Value(id: '12', text: 'Value 12?'),
        Value(id: '15', text: 'Value 15¿'),
      ];

      SharedPreferences.setMockInitialValues({
        'custom_values':
            customValues.map((e) => jsonEncode(e.toJson())).toList(),
      });

      GlobalKey key = GlobalKey();

      await tester.pumpWidget(MockupApp(
        child: Container(key: key),
      ));

      // Verify that ValuesProvider favoritesIds is empty.
      expect(
        Provider.of<ValuesProvider>(
          key.currentContext,
          listen: false,
        ).values,
        isEmpty,
      );

      // Load saved custom values from device storage.
      await loadValues(key.currentContext, offline: true);


      // Verify that ValuesProvider values contains correct values.
      // It compares Iterable of json maps because comparing list of class
      // instances can be problematic
      expect(
        Provider.of<ValuesProvider>(
          key.currentContext,
          listen: false,
        ).values.map((e) => e.toJson()),
        equals(customValues.map((e) => e.toJson())),
      );
    });
  });
}
