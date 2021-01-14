import 'package:meta/meta.dart';

/// Value model. We are using class instead just a string to use ids and avoid
/// duplicates etc.
class Value {
  Value({
    @required this.id,
    @required this.text,
    this.canBeDeleted = true,
  });

  /// Value id
  final int id;

  /// Value text
  final String text;

  /// Defaults to `false` for Seven Core Values
  final bool canBeDeleted;
}
