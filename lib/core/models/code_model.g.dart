// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CodeModelAdapter extends TypeAdapter<CodeModel> {
  @override
  final int typeId = 1;

  @override
  CodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CodeModel(
      dataType: fields[0] as String?,
      data: fields[1] as String?,
      scanedOn: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CodeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dataType)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.scanedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
