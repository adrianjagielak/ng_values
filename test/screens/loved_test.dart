import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/screens/loved.dart';
import 'package:ng_values/widgets/loved/loved_list_item.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';

void main() {
  group('Loved screen', () {
    testWidgets('remove value from favorites', (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        values: [Value(id: '9', text: 'test quote 9!')],
        favoritesIds: ['9'],
        child: Loved(),
      ));

      // Verify that one value is loved.
      expect(
        find.descendant(
          of: find.byType(LovedListItem),
          matching: find.text('test quote 9!'),
        ),
        findsOneWidget,
      );

      // Tap the unlove favorite.
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Accept the prompt.
      await tester.tap(find.text('OK'));
      await tester.pump();

      // Verify that no value is loved.
      expect(find.byType(LovedListItem), findsNothing);
      expect(
        find.text('Love something and it will be displayed here :)'),
        findsOneWidget,
      );
    });
  });
}
