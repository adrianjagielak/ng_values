import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/services/providers/favorites_provider.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FavoritesProvider', () {
    testWidgets('load favorites from device storage',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'favorites': ['0', '15', '42'],
      });

      GlobalKey key = GlobalKey();

      await tester.pumpWidget(MockupApp(
        child: Container(key: key),
      ));

      // Verify that FavoritesProvider favoritesIds is empty.
      expect(
        Provider.of<FavoritesProvider>(
          key.currentContext,
          listen: false,
        ).favoritesIds,
        isEmpty,
      );

      // Load saved favorites from device storage.
      await loadSavedFavorites(key.currentContext);

      // Verify that FavoritesProvider favoritesIds contains correct values.
      expect(
        Provider.of<FavoritesProvider>(
          key.currentContext,
          listen: false,
        ).favoritesIds,
        equals([0, 15, 42]),
      );
    });
  });
}
