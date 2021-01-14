import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'value.g.dart';

/// Value model. We are using class instead just a string to use ids and avoid
/// duplicates etc.
@JsonSerializable()
class Value {
  Value({
    @required this.id,
    @required this.text,
    this.canBeDeleted = true,
  });

  factory Value.fromJson(Map<String, dynamic> json) =>
      _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  /// Value id
  final int id;

  /// Value text
  final String text;

  /// Defaults to `false` for Seven Core Values
  final bool canBeDeleted;
}
