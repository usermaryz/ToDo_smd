// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelImplAdapter extends TypeAdapter<_$TaskModelImpl> {
  @override
  final int typeId = 0;

  @override
  _$TaskModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TaskModelImpl(
      id: fields[0] as String,
      text: fields[1] as String,
      importance: fields[2] as String,
      done: fields[3] as bool,
      deadline: fields[4] as DateTime?,
      color: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      changedAt: fields[7] as DateTime,
      lastUpdatedBy: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$TaskModelImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.importance)
      ..writeByte(3)
      ..write(obj.done)
      ..writeByte(4)
      ..write(obj.deadline)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.changedAt)
      ..writeByte(8)
      ..write(obj.lastUpdatedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      done: json['done'] as bool,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      color: json['color'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      changedAt: DateTime.parse(json['changedAt'] as String),
      lastUpdatedBy: json['lastUpdatedBy'] as String,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'done': instance.done,
      'deadline': instance.deadline?.toIso8601String(),
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
      'changedAt': instance.changedAt.toIso8601String(),
      'lastUpdatedBy': instance.lastUpdatedBy,
    };
