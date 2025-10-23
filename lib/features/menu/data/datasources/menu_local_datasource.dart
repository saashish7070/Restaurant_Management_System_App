import 'package:hive/hive.dart';
import '../models/menu_item_model.dart';

abstract class LocalMenuDataSource {
  Future<void> cacheMenu(String restaurantId, List<MenuItemModel> items);
  Future<List<MenuItemModel>> getCachedMenu(String restaurantId);
  Future<List<MenuItemModel>> getPendingItems(String restaurantId);
  Future<void> addItem(String restaurantId, MenuItemModel item);
  Future<void> updateItem(String restaurantId, MenuItemModel item);
  Future<void> deleteItem(String restaurantId, String id);
  Future<void> markAsSynced(String restaurantId, String id);
}

class LocalMenuDataSourceImpl implements LocalMenuDataSource {
  final HiveInterface hive;
  LocalMenuDataSourceImpl(this.hive);

  String _boxName(String restaurantId) => 'menu_$restaurantId';

  @override
  Future<void> cacheMenu(String restaurantId, List<MenuItemModel> items) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    await box.clear();
    for (final item in items) {
      await box.put(item.id, item);
    }
    await box.close();
  }

  @override
  Future<List<MenuItemModel>> getCachedMenu(String restaurantId) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    final items = box.values.toList();
    await box.close();
    return items;
  }

  @override
  Future<void> addItem(String restaurantId, MenuItemModel item) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    await box.put(item.id, item);
    await box.close();
  }

  @override
  Future<void> updateItem(String restaurantId, MenuItemModel item) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    await box.put(item.id, item);
    await box.close();
  }

  @override
  Future<void> deleteItem(String restaurantId, String id) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    await box.delete(id);
    await box.close();
  }
  
  @override
  Future<List<MenuItemModel>> getPendingItems(String restaurantId) async {
    final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
    final pending = box.values.where((item) => item.isPendingSync).toList();
    await box.close();
    return pending;
  }

  Future<void> markAsSynced(String restaurantId, String id) async {
  final box = await hive.openBox<MenuItemModel>(_boxName(restaurantId));
  final item = box.get(id);
  if (item != null) {
    item.isPendingSync = false;
    await box.put(id, item);
  }
  await box.close();
}

}
