import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_values/models/value.dart';
import 'package:ng_values/widgets/loved/loved_list_item.dart';
import 'package:ng_values/widgets/test/mockup_app.dart';

void main() {
  group('LovedListItem', () {
    testWidgets('correctly displays value for given favorite id',
        (WidgetTester tester) async {
      await tester.pumpWidget(MockupApp(
        values: [Value(id: '1138', text: 'Star Wars!')],
        favoritesIds: ['1138'],
        child: LovedListItem(
          id: '1138',
        ),
      ));

      // Verify that the widget displays value text.
      expect(find.text('Star Wars!'), findsOneWidget);

      // Verify that remove icon is available.
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
  });
}
