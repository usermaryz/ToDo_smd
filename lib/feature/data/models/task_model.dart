import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/feature/domain/entities/task_entity.dart';
part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  @HiveType(typeId: 0)
  const factory TaskModel({
    @HiveField(0) required String id,
    @HiveField(1) required String text,
    @HiveField(2) required String importance,
    @HiveField(3) required bool done,
    @HiveField(4) DateTime? deadline,
    @HiveField(5) String? color,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) required DateTime changedAt,
    @HiveField(8) required String lastUpdatedBy,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

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
}

extension TaskModelX on TaskModel {
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