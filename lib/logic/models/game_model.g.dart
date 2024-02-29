// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameModelAdapter extends TypeAdapter<GameModel> {
  @override
  final int typeId = 2;

  @override
  GameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModel(
      listOfKeysWords: (fields[0] as List).cast<CategoriesEnum>(),
      listOfTeams: (fields[1] as List).cast<TeamModel>(),
      timeOfRound: fields[2] as int,
      listOfRounds: (fields[3] as List).cast<RoundModel>(),
      isGameStarted: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.listOfKeysWords)
      ..writeByte(1)
      ..write(obj.listOfTeams)
      ..writeByte(2)
      ..write(obj.timeOfRound)
      ..writeByte(3)
      ..write(obj.listOfRounds)
      ..writeByte(4)
      ..write(obj.isGameStarted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
