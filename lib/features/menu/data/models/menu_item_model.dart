import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/menu_item.dart';

part 'menu_item_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class MenuItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String price;
  @HiveField(3)
  bool available;
  @HiveField(4)
  List<String> cuisine;
  @HiveField(5)
  List<String> categories;
  @HiveField(6)
  bool typeItem;
  @HiveField(7)
  String imageUrl;
  @HiveField(8)
  String ingredient;
  @HiveField(9)
  bool isPendingSync;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.cuisine,
    required this.categories,
    required this.typeItem,
    required this.imageUrl,
    required this.ingredient,
    this.isPendingSync = false,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => _$MenuItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemModelToJson(this);

  MenuItemEntity toEntity() => MenuItemEntity(
        id: id,
        name: name,
        price: price,
        available: available,
        cuisine: cuisine,
        categories: categories,
        typeItem: typeItem,
        imageUrl: imageUrl,
        ingredient: ingredient,
      );

  factory MenuItemModel.fromEntity(MenuItemEntity e) => MenuItemModel(
        id: e.id,
        name: e.name,
        price: e.price,
        available: e.available,
        cuisine: e.cuisine,
        categories: e.categories,
        typeItem: e.typeItem,
        imageUrl: e.imageUrl,
        ingredient: e.ingredient,
      );
}
