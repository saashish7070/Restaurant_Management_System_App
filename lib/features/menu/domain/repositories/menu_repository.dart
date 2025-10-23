import '../entities/menu_item.dart';

abstract class MenuRepository {
  Future<List<MenuItemEntity>> getMenu(String restaurantId);
  Future<void> addItem(String restaurantId, MenuItemEntity item);
  Future<void> updateItem(String restaurantId, MenuItemEntity item);
  Future<void> deleteItem(String restaurantId, String id);
  Future<void> syncPendingItems(String restaurantId);
}
