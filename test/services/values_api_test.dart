import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:ng_values/models/value.dart';
import 'package:ng_values/services/values_api.dart';

void main() {
  List<Value> coreValues;

  setUp(() async {
    coreValues = await getCoreValues();
  });

  group('getCoreValues endpoint', () {
    test('correctly returns the Seven Core Values', () {
      expect(coreValues.length, equals(7));

      expect(
        coreValues[0].text,
        equals(
          "Exceed clients' and colleagues' expectations",
        ),
      );
      expect(
        coreValues[1].text,
        equals(
          'Take ownership and question the status quo in a constructive manner',
        ),
      );
      expect(
        coreValues[2].text,
        equals(
          'Be brave, curious and experiment. Learn from all successes and '
          'failures',
        ),
      );
      expect(
        coreValues[3].text,
        equals(
          'Act in a way that makes all of us proud',
        ),
      );
      expect(
        coreValues[4].text,
        equals(
          'Build an inclusive, transparent and socially responsible culture',
        ),
      );
      expect(
        coreValues[5].text,
        equals(
          'Be ambitious, grow yourself and the people around you',
        ),
      );
      expect(
        coreValues[6].text,
        equals(
          'Recognize excellence and engagement',
        ),
      );

      expect(coreValues[0].id, equals(0));
      expect(coreValues[1].id, equals(1));
      expect(coreValues[2].id, equals(2));
      expect(coreValues[3].id, equals(3));
      expect(coreValues[4].id, equals(4));
      expect(coreValues[5].id, equals(5));
      expect(coreValues[6].id, equals(6));

      // All of values from API should have canBeDeleted == false
      expect(coreValues.where((e) => e.canBeDeleted == true).isEmpty, isTrue);
    });
  });
}
