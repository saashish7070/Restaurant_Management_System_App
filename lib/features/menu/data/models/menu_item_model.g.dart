// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuItemModelAdapter extends TypeAdapter<MenuItemModel> {
  @override
  final int typeId = 0;

  @override
  MenuItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuItemModel(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as String,
      available: fields[3] as bool,
      cuisine: (fields[4] as List).cast<String>(),
      categories: (fields[5] as List).cast<String>(),
      typeItem: fields[6] as bool,
      imageUrl: fields[7] as String,
      ingredient: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MenuItemModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.available)
      ..writeByte(4)
      ..write(obj.cuisine)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.typeItem)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.ingredient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemModel _$MenuItemModelFromJson(Map<String, dynamic> json) =>
    MenuItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      available: json['available'] as bool,
      cuisine:
          (json['cuisine'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      typeItem: json['typeItem'] as bool,
      imageUrl: json['imageUrl'] as String,
      ingredient: json['ingredient'] as String,
    );

Map<String, dynamic> _$MenuItemModelToJson(MenuItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'available': instance.available,
      'cuisine': instance.cuisine,
      'categories': instance.categories,
      'typeItem': instance.typeItem,
      'imageUrl': instance.imageUrl,
      'ingredient': instance.ingredient,
    };
