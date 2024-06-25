// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HivePrivateChatModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePrivateChatModelAdapter extends TypeAdapter<HivePrivateChatModel> {
  @override
  final int typeId = 0;

  @override
  HivePrivateChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePrivateChatModel(
      messageId: fields[0] as String?,
      message: fields[1] as String,
      sender: fields[2] as String,
      receiver: fields[3] as String,
      timeStamp: fields[4] as String,
      isSeen: fields[5] as bool,
      messageType: fields[6] as String,
      replayMessage: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HivePrivateChatModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.messageId)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.receiver)
      ..writeByte(4)
      ..write(obj.timeStamp)
      ..writeByte(5)
      ..write(obj.isSeen)
      ..writeByte(6)
      ..write(obj.messageType)
      ..writeByte(7)
      ..write(obj.replayMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePrivateChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
