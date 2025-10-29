// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_entity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdersEntityModelAdapter extends TypeAdapter<OrdersEntityModel> {
  @override
  final int typeId = 2;

  @override
  OrdersEntityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdersEntityModel(
      id: fields[0] as String,
      orderIds: (fields[1] as List?)?.cast<String>(),
      orderStatusString: fields[2] as String,
      orderTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrdersEntityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderIds)
      ..writeByte(2)
      ..write(obj.orderStatusString)
      ..writeByte(3)
      ..write(obj.orderTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersEntityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersEntityModel _$OrdersEntityModelFromJson(Map<String, dynamic> json) =>
    OrdersEntityModel(
      id: json['id'] as String,
      orderIds: (json['orderIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orderStatusString: json['orderStatus'] as String,
      orderTime: (json['orderTime'] as num).toInt(),
    );

Map<String, dynamic> _$OrdersEntityModelToJson(OrdersEntityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderIds': instance.orderIds,
      'orderStatus': instance.orderStatusString,
      'orderTime': instance.orderTime,
    };
