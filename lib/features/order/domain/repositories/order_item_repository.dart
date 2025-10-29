import 'package:rms/features/order/domain/entities/order_entity';

abstract class OrderItemRepository {
  Future<void> addOrderItem(String tableNumber, String orderId, OrderItem item);
}