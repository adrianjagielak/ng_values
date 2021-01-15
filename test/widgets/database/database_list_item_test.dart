import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/widgets/database/database_list_item.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';

void main() {
  group('DatabaseListItem', () {
    testWidgets('correctly displays given value for Core Value',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        child: DatabaseListItem(
          value: Value(
            id: '0',
            text: 'test value 1',
            canBeDeleted: false,
          ),
        ),
      ));

      // Verify that no hearts are filled.
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      // Verify that the widget displays value text.
      expect(find.text('test value 1'), findsOneWidget);

      // Verify that no remove icon is available.
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('correctly displays given value for non-core favorite value',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        favoritesIds: [
          '15',
        ],
        child: DatabaseListItem(
          value: Value(
            id: '15',
            text: 'test value 15',
          ),
        ),
      ));

      // Verify that a heart is filled.
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline), findsNothing);

      // Verify that the widget displays value text.
      expect(find.text('test value 15'), findsOneWidget);

      // Verify that remove icon is available.
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
  });
}
