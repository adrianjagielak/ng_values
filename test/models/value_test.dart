import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:ng_values/models/value.dart';

void main() {
  Value valueFromJson;

  setUp(() {
    valueFromJson = Value.fromJson(
        jsonDecode('{"id":0,"text":"qwerty123","canBeDeleted":false}'));
  });

  group('Value.fromJson', () {
    test('correctly parses JSON input', () {
      expect(valueFromJson.id, equals(0));
      expect(valueFromJson.text, equals('qwerty123'));
      expect(valueFromJson.canBeDeleted, equals(false));
    });
  });
}
