import 'package:hive/hive.dart';
import '../../domain/entities/restaurant_entity.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 2)
class RestaurantModel extends RestaurantEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final String menuId;

  @HiveField(4)
  final String orderId;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.location,
    required this.menuId,
    required this.orderId,
  }) : super(
          id: id,
          name: name,
          location: location,
          menuId: menuId,
          orderId: orderId,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        location: json['location'] ?? '',
        menuId: json['menuId'] ?? '',
        orderId: json['orderId'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'menuId': menuId,
        'orderId': orderId,
      };
}
