import '../entities/menu_item.dart';

abstract class MenuRepository {
  Future<void> addMenuItem(MenuItemEntity item);
  Future<List<MenuItemEntity>> getMenuItems();
  Future<void> deleteMenuItem(String id);
  Future<void> updateMenuItem(MenuItemEntity item);
}
