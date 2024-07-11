/*// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      done: json['done'] as bool,
      createdAt: (json['createdAt'] as num).toInt(),
      changedAt: (json['changedAt'] as num).toInt(),
      lastUpdatedBy: json['lastUpdatedBy'] as String,
      deadline: (json['deadline'] as num?)?.toInt(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'deadline': instance.deadline,
      'done': instance.done,
      'color': instance.color,
      'createdAt': instance.createdAt,
      'changedAt': instance.changedAt,
      'lastUpdatedBy': instance.lastUpdatedBy,
    };
*/