import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/screens/database.dart';
import 'package:ng_values/widgets/database/database_list_item.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';

void main() {
  group('Database screen', () {
    testWidgets('add value to favorites', (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        values: [
          Value(
            id: '0',
            text: 'test value',
          )
        ],
        child: Database(),
      ));

      // Verify that no hearts are filled.
      expect(find.byIcon(Icons.favorite), findsNothing);

      // Tap the heart icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.favorite_outline));
      await tester.pump();

      // Verify that one of hearts is filled.
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('add new value to the storage', (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        child: Database(),
      ));

      // Verify that database list is empty.
      expect(find.byType(DatabaseListItem), findsNothing);

      // Tap the fab button.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Input a new value.
      await tester.enterText(find.byType(TextField), 'New Value!');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify that database contains a new value.
      expect(find.byType(DatabaseListItem), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(DatabaseListItem),
          matching: find.text('New Value!'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(DatabaseListItem),
          matching: find.byIcon(Icons.favorite),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(DatabaseListItem),
          matching: find.byIcon(Icons.favorite_outline),
        ),
        findsOneWidget,
      );
    });
  });
}
