// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      done: json['done'] as bool,
      created_at: (json['created_at'] as num).toInt(),
      changed_at: (json['changed_at'] as num).toInt(),
      last_updated_by: json['last_updated_by'] as String,
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
      'created_at': instance.created_at,
      'changed_at': instance.changed_at,
      'last_updated_by': instance.last_updated_by,
    };
