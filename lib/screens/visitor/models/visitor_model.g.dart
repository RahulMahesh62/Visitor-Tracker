// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitorAdapter extends TypeAdapter<Visitor> {
  @override
  final int typeId = 0;

  @override
  Visitor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visitor(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Visitor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
