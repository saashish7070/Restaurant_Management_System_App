import 'package:rms/features/order/domain/entities/table_order.dart';


abstract class TableOrderRepository {
  Future<void> addTable(TableOrder tableOrder);
  Future<TableOrder> getTable(String tableNumber);
  Future<void> addOrderToTable(String tableNumber, String orderId);
  Future<void> updateTableSeatedStatus(String tableNumber, bool seated);
}