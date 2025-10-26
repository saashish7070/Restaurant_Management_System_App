import 'package:hive_flutter/hive_flutter.dart';
import '../models/menu_item_model.dart';

abstract class MenuLocalDataSource {
  Future<void> cacheMenuItem(MenuItemModel item);
  Future<List<MenuItemModel>> getCachedMenuItems();
  Future<void> deleteCachedMenuItem(String id);
  Future<void> updateCachedMenuItem(MenuItemModel item);
}

class MenuLocalDataSourceImpl implements MenuLocalDataSource {
  final Box<MenuItemModel> box;
  MenuLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheMenuItem(MenuItemModel item) async {
    await box.put(item.id, item);
  }

  @override
  Future<List<MenuItemModel>> getCachedMenuItems() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteCachedMenuItem(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> updateCachedMenuItem(MenuItemModel item) async {
    await box.put(item.id, item);
  }
}
