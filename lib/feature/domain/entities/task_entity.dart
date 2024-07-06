import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int importance; // Changed to int

  @HiveField(3)
  final DateTime? deadline; // Changed to DateTime

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
      id: _uuidToInt(json['id'] as String),
      text: json['text'] as String,
      importance: _importanceFromString(json['importance'] as String),
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
      'importance': _importanceToString(importance),
      'deadline': deadline?.millisecondsSinceEpoch,
      'done': done,
      'color': color,
      'created_at': createdAt,
      'changed_at': changedAt,
      'last_updated_by': lastUpdatedBy,
    };
  }

  TaskEntity copyWith({
    int? id,
    String? text,
    int? importance,
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

  static int _importanceFromString(String importance) {
    switch (importance) {
      case 'low':
        return 1;
      case 'basic':
        return 2;
      case 'important':
        return 3;
      default:
        return 2; // default to 'basic'
    }
  }

  static String _importanceToString(int importance) {
    switch (importance) {
      case 1:
        return 'low';
      case 2:
        return 'basic';
      case 3:
        return 'important';
      default:
        return 'basic'; // default to 'basic'
    }
  }

  static int _uuidToInt(String uuid) {
    var bytes = utf8.encode(uuid); // Encode UUID string to bytes
    var digest = sha256.convert(bytes); // Generate SHA-256 hash of the bytes
    // Parse the first 8 characters of the hexadecimal representation of the hash
    return int.parse(digest.toString().substring(0, 8), radix: 16);
  }
}
