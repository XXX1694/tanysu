// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  final int typeId = 0;

  @override
  ChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      id: fields[0] as int,
      profile_id: fields[1] as int?,
      chat_name: fields[2] as String?,
      chat_type: fields[3] as String,
      last_message: fields[4] as String?,
      chat_photo: fields[5] as String?,
      unread: fields[6] as int?,
      online: fields[7] as bool?,
      last_message_time: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.profile_id)
      ..writeByte(2)
      ..write(obj.chat_name)
      ..writeByte(3)
      ..write(obj.chat_type)
      ..writeByte(4)
      ..write(obj.last_message)
      ..writeByte(5)
      ..write(obj.chat_photo)
      ..writeByte(6)
      ..write(obj.unread)
      ..writeByte(7)
      ..write(obj.online)
      ..writeByte(8)
      ..write(obj.last_message_time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: (json['id'] as num).toInt(),
      profile_id: (json['profile_id'] as num?)?.toInt(),
      chat_name: json['chat_name'] as String?,
      chat_type: json['chat_type'] as String,
      last_message: json['last_message'] as String?,
      chat_photo: json['chat_photo'] as String?,
      unread: (json['unread'] as num?)?.toInt(),
      online: json['online'] as bool?,
      last_message_time: json['last_message_time'] == null
          ? null
          : DateTime.parse(json['last_message_time'] as String),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profile_id,
      'chat_name': instance.chat_name,
      'chat_type': instance.chat_type,
      'last_message': instance.last_message,
      'chat_photo': instance.chat_photo,
      'unread': instance.unread,
      'online': instance.online,
      'last_message_time': instance.last_message_time?.toIso8601String(),
    };
