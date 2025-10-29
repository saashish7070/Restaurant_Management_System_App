import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rms/features/order/domain/entities/orders_entity.dart';

part 'orders_entity_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class OrdersEntityModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<String>? orderIds;
  @HiveField(2)
  @JsonKey(name: 'orderStatus')
  final String orderStatusString;
  @HiveField(3)
  final int orderTime;

  OrdersEntityModel({
    required this.id,
    this.orderIds,
    required this.orderStatusString,
    required this.orderTime,
  });

  factory OrdersEntityModel.fromJson(Map<String, dynamic> json) => _$OrdersEntityModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersEntityModelToJson(this);

  OrdersEntity toEntity() => OrdersEntity(
        id: id,
        orderIds: orderIds,
        orderStatus: OrderStatus.values.firstWhere(
          (e) => e.name == orderStatusString,
          orElse: () => OrderStatus.empty,
        ),
        orderTime: DateTime.fromMillisecondsSinceEpoch(orderTime),
      );

  factory OrdersEntityModel.fromEntity(OrdersEntity e) => OrdersEntityModel(
        id: e.id,
        orderIds: e.orderIds,
        orderStatusString: e.orderStatus.name,
        orderTime: e.orderTime.millisecondsSinceEpoch,
      );
}