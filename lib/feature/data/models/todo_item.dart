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
  int createdAt;
  int changedAt;
  String lastUpdatedBy;

  TodoItem({
    required this.id,
    required this.text,
    required this.importance,
    required this.done,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
    this.deadline,
    this.color,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
