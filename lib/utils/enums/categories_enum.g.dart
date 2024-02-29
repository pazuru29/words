// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesEnumAdapter extends TypeAdapter<CategoriesEnum> {
  @override
  final int typeId = 3;

  @override
  CategoriesEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoriesEnum.football;
      case 1:
        return CategoriesEnum.basketball;
      case 2:
        return CategoriesEnum.baseball;
      case 3:
        return CategoriesEnum.rugby;
      case 4:
        return CategoriesEnum.hockey;
      default:
        return CategoriesEnum.football;
    }
  }

  @override
  void write(BinaryWriter writer, CategoriesEnum obj) {
    switch (obj) {
      case CategoriesEnum.football:
        writer.writeByte(0);
        break;
      case CategoriesEnum.basketball:
        writer.writeByte(1);
        break;
      case CategoriesEnum.baseball:
        writer.writeByte(2);
        break;
      case CategoriesEnum.rugby:
        writer.writeByte(3);
        break;
      case CategoriesEnum.hockey:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
