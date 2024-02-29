// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundModelAdapter extends TypeAdapter<RoundModel> {
  @override
  final int typeId = 4;

  @override
  RoundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoundModel(
      id: fields[0] as String,
      team: fields[1] as TeamModel,
      name: fields[2] as String,
      currentWord: fields[5] as String?,
      currentTime: fields[6] as double,
      listOfUsedWords: (fields[4] as List).cast<String>(),
      points: fields[3] as int,
      isFinished: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RoundModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.team)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.points)
      ..writeByte(4)
      ..write(obj.listOfUsedWords)
      ..writeByte(5)
      ..write(obj.currentWord)
      ..writeByte(6)
      ..write(obj.currentTime)
      ..writeByte(7)
      ..write(obj.isFinished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
