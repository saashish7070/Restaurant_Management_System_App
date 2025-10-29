// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableOrderModelAdapter extends TypeAdapter<TableOrderModel> {
  @override
  final int typeId = 3;

  @override
  TableOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableOrderModel(
      tableNumber: fields[0] as String,
      orderIds: (fields[1] as List).cast<String>(),
      seated: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TableOrderModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tableNumber)
      ..writeByte(1)
      ..write(obj.orderIds)
      ..writeByte(2)
      ..write(obj.seated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableOrderModel _$TableOrderModelFromJson(Map<String, dynamic> json) =>
    TableOrderModel(
      tableNumber: json['tableNumber'] as String,
      orderIds:
          (json['orderIds'] as List<dynamic>).map((e) => e as String).toList(),
      seated: json['seated'] as bool,
    );

Map<String, dynamic> _$TableOrderModelToJson(TableOrderModel instance) =>
    <String, dynamic>{
      'tableNumber': instance.tableNumber,
      'orderIds': instance.orderIds,
      'seated': instance.seated,
    };
