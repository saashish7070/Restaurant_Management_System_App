import 'package:rms/features/order/domain/entities/orders_entity.dart';


abstract class OrdersEntityRepository {
  Future<void> addOrder(String tableNumber, OrdersEntity order);
}