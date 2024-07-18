import 'package:hive/hive.dart';
part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String importance;

  @HiveField(3)
  final DateTime? deadline;

  @HiveField(4)
  final bool done;

  @HiveField(5)
  final String? color;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime changedAt;

  @HiveField(8)
  final String lastUpdatedBy;

  TaskEntity({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      deadline: json['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int)
          : null,
      done: json['done'] as bool,
      color: json['color'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      changedAt: DateTime.fromMillisecondsSinceEpoch(json['changed_at'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'importance': importance,
      'deadline': deadline?.millisecondsSinceEpoch,
      'done': done,
      'color': color,
      'created_at': createdAt.millisecondsSinceEpoch,
      'changed_at': changedAt.millisecondsSinceEpoch,
      'last_updated_by': lastUpdatedBy,
    };
  }

  TaskEntity copyWith({
    String? id,
    String? text,
    String? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }
}

class TaskListResponse {
  final String status;
  final List<TaskEntity> list;
  final int revision;

  TaskListResponse({
    required this.status,
    required this.list,
    required this.revision,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    return TaskListResponse(
      status: json['status'] as String,
      list: (json['list'] as List)
          .map((taskJson) => TaskEntity.fromJson(taskJson))
          .toList(),
      revision: json['revision'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'list': list.map((task) => task.toJson()).toList(),
      'revision': revision,
    };
  }
}
