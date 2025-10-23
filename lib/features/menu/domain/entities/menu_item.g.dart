// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemEntityImpl _$$MenuItemEntityImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemEntityImpl(
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

Map<String, dynamic> _$$MenuItemEntityImplToJson(
        _$MenuItemEntityImpl instance) =>
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
