import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends TaskEntity {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String text;

  @override
  @HiveField(2)
  final String importance;

  @override
  @HiveField(3)
  final bool done;

  @override
  @HiveField(4)
  final DateTime? deadline;

  @override
  @HiveField(5)
  final String? color;

  @override
  @HiveField(6)
  final DateTime createdAt;

  @override
  @HiveField(7)
  final DateTime changedAt;

  @override
  @HiveField(8)
  final String lastUpdatedBy;

  TaskModel(
      {required this.id,
      required this.text,
      required this.importance,
      this.deadline,
      required this.done,
      this.color,
      required this.createdAt,
      required this.changedAt,
      required this.lastUpdatedBy})
      : super(
          id: id,
          text: text,
          importance: importance,
          deadline: deadline,
          done: done,
          color: color,
          createdAt: createdAt,
          changedAt: changedAt,
          lastUpdatedBy: lastUpdatedBy,
        );

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      text: entity.text,
      importance: entity.importance,
      deadline: entity.deadline,
      done: entity.done,
      color: entity.color,
      createdAt: entity.createdAt,
      changedAt: entity.changedAt,
      lastUpdatedBy: entity.lastUpdatedBy,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      text: text,
      importance: importance,
      deadline: deadline,
      done: done,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}
