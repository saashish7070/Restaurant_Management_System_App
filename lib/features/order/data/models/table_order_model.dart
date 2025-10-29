import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rms/features/order/domain/entities/table_order.dart';


part 'table_order_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class TableOrderModel {
  @HiveField(0)
  final String tableNumber;
  @HiveField(1)
  final List<String> orderIds;
  @HiveField(2)
  final bool seated;

  TableOrderModel({
    required this.tableNumber,
    required this.orderIds,
    required this.seated,
  });

  factory TableOrderModel.fromJson(Map<String, dynamic> json) => _$TableOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableOrderModelToJson(this);

  TableOrder toEntity() => TableOrder(
        tableNumber: tableNumber,
        orderIds: orderIds,
        seated: seated,
      );

  factory TableOrderModel.fromEntity(TableOrder e) => TableOrderModel(
        tableNumber: e.tableNumber,
        orderIds: e.orderIds,
        seated: e.seated,
      );
}