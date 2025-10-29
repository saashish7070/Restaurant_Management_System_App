import 'package:hive_flutter/hive_flutter.dart';
import '../models/order_item_model.dart';

abstract class OrderItemLocalDataSource {
  Future<void> cacheMenuItem(OrderItemModel item);
  Future<List<OrderItemModel>> getCachedMenuItems();
  Future<OrderItemModel?> getCachedMenuItem(String menuItemId);
  Future<void> deleteCachedMenuItem(String menuItemId);
  Future<void> updateCachedMenuItem(OrderItemModel item);
}

class OrderItemLocalDataSourceImpl implements OrderItemLocalDataSource {
  final Box<OrderItemModel> box;
  OrderItemLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheMenuItem(OrderItemModel item) async {
    await box.put(item.menuItemId, item);
  }

  @override
  Future<List<OrderItemModel>> getCachedMenuItems() async {
    return box.values.toList();
  }

  @override
  Future<OrderItemModel?> getCachedMenuItem(String menuItemId) async {
    return box.get(menuItemId);
  }

  @override
  Future<void> deleteCachedMenuItem(String menuItemId) async {
    await box.delete(menuItemId);
  }

  @override
  Future<void> updateCachedMenuItem(OrderItemModel item) async {
    await box.put(item.menuItemId, item);
  }
}