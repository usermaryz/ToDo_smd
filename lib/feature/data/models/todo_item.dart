import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  String id;
  String text;
  String importance;
  int? deadline;
  bool done;
  String? color;
  int created_at;
  int changed_at;
  String last_updated_by;

  TodoItem({
    required this.id,
    required this.text,
    required this.importance,
    required this.done,
    required this.created_at,
    required this.changed_at,
    required this.last_updated_by,
    this.deadline,
    this.color,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
