import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rms/features/order/domain/entities/order_entity';


part 'order_item_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class OrderItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String menuItemId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final String? note;

  OrderItemModel({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.price,
    this.note,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItem toEntity() => OrderItem(
        id: id,
        menuItemId: menuItemId,
        name: name,
        quantity: quantity,
        price: price,
        note: note,
      );

  factory OrderItemModel.fromEntity(OrderItem e) => OrderItemModel(
        id: e.id,
        menuItemId: e.menuItemId,
        name: e.name,
        quantity: e.quantity,
        price: e.price,
        note: e.note,
      );
}