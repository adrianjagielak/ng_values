import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/screens/values.dart';
import 'package:ng_values/services/providers/favorites_provider.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';
import 'package:provider/provider.dart';

void main() {
  group('Values screen', () {
    testWidgets('displays random Value from database',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MockupApp(
          values: [
            Value(
              id: '0',
              text: 'test value',
            ),
            Value(
              id: '1',
              text: 'test value',
            ),
          ],
          child: Values(),
        ),
      );

      // Trigger a frame.
      await tester.pump();

      // Verify that a value is displayed.
      expect(find.text('test value'), findsOneWidget);
    });

    testWidgets('refresh displayed value after 5 seconds',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        values: [
          Value(
            id: '0',
            text: 'test value 0',
          ),
          Value(
            id: '1',
            text: 'test value 1',
          ),
        ],
        child: Values(),
      ));

      // Trigger a frame.
      await tester.pump();

      // If 'test value 0' is displayed
      if (find.text('test value 0').evaluate().isNotEmpty) {
        await tester.pump(Duration(milliseconds: 5500));

        // Verify that after 5500ms 'test value 1' is displayed..
        expect(find.text('test value 1'), findsOneWidget);
      } else {
        await tester.pump(Duration(milliseconds: 5500));

        // Verify that after 5500ms 'test value 0' is displayed..
        expect(find.text('test value 0'), findsOneWidget);
      }
    });

    testWidgets('refresh displayed value after clicking "Refresh"',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        values: [
          Value(
            id: '0',
            text: 'test value 0',
          ),
          Value(
            id: '1',
            text: 'test value 1',
          ),
        ],
        child: Values(),
      ));

      // Trigger a frame.
      await tester.pump();

      // If 'test value 0' is displayed
      if (find.text('test value 0').evaluate().isNotEmpty) {
        // Tap the refresh button and trigger a frame.
        await tester.tap(find.text('Refresh'));
        await tester.pump();

        // Verify that after 5500ms 'test value 1' is displayed..
        expect(find.text('test value 1'), findsOneWidget);
      } else {
        // Tap the refresh button and trigger a frame.
        await tester.tap(find.text('Refresh'));
        await tester.pump();

        // Verify that after 5500ms 'test value 0' is displayed..
        expect(find.text('test value 0'), findsOneWidget);
      }
    });

    testWidgets('add value to favorites after clicking FAB',
        (WidgetTester tester) async {
      // Keep the key for getting the context later.
      GlobalKey key = GlobalKey();

      await tester.pumpWidget(MockupApp(
        values: [
          Value(
            id: '0',
            text: 'test value',
          ),
          Value(
            id: '1',
            text: 'test value',
          ),
        ],
        child: Values(key: key),
      ));

      // Trigger a frame.
      await tester.pump();

      // Verify that FavoritesProvider favoritesIds is empty.
      expect(
        Provider.of<FavoritesProvider>(
          key.currentContext,
          listen: false,
        ).favoritesIds,
        isEmpty,
      );

      // Tap the 'Add to favorites' button and trigger a frame.
      await tester.tap(find.text('Add to favorites'));
      await tester.pump();

      // Verify that FavoritesProvider favoritesIds is not empty.
      expect(
        Provider.of<FavoritesProvider>(
          key.currentContext,
          listen: false,
        ).favoritesIds,
        isNotEmpty,
      );
    });
  });
}
