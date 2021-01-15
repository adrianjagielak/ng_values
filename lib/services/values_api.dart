import 'dart:developer';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html show parse;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/value.dart';

const String _baseUrl = 'www.netguru.com';

/// Returns the List of [Value]s of the Seven Core Values.
///
/// The point of this pseudo-api is mainly to demonstrate usage of REST api
Future<List<Value>> getCoreValues() async {
  List<Value> result;

  try {
    Response r = await http.get(
      Uri.https(
        _baseUrl,
        'codestories/netgurus-core-values-and-their-impact-according-to-the-team',
      ),
    );

    // Parse html blog post about Seven Core Values™
    Document doc = html.parse(r.body);

    result = doc
        // the location of Seven Core Values is ol > li > span
        .querySelectorAll('ol span')
        .map(
          (e) => Value(
            // Since we are using pseudo-api id can be the same as text
            id: e.text,
            text: e.text,
            canBeDeleted: false,
          ),
        )
        .toList();
  } catch (e) {
    log('Getting response from api failed. Error: $e');

    // Since we know Seven Core Values anyway we might as well just load them
    // from hard-coded strings
    result = [
      "Exceed clients' and colleagues' expectations",
      'Take ownership and question the status quo in a constructive manner',
      'Be brave, curious and experiment. Learn from all successes and failures',
      'Act in a way that makes all of us proud',
      'Build an inclusive, transparent and socially responsible culture',
      'Be ambitious, grow yourself and the people around you',
      'Recognize excellence and engagement',
    ]
        .map((e) => Value(
              // Since we are using pseudo-api id can be the same as text
              id: e,
              text: e,
              canBeDeleted: false,
            ))
        .toList();
  }

  return result;
}
