import 'package:rms/features/menu/data/datasources/menu_local_datasource.dart';
import 'package:rms/features/menu/data/datasources/menu_remote_datasource.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';

import '../../domain/repositories/menu_repository.dart';
import '../models/menu_item_model.dart';

class MenuRepositoryImpl implements MenuRepository {
  final LocalMenuDataSource local;
  final RemoteMenuDataSource remote;

  MenuRepositoryImpl({required this.local, required this.remote});

  @override
  Future<List<MenuItemEntity>> getMenu(String restaurantId) async {
    try {
      final remoteItems = await remote.fetchMenu(restaurantId);
      await local.cacheMenu(restaurantId, remoteItems);
      return remoteItems.map((e) => e.toEntity()).toList();
    } catch (_) {
      final cached = await local.getCachedMenu(restaurantId);
      return cached.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<void> addItem(String restaurantId, MenuItemEntity e) async {
    final model = MenuItemModel.fromEntity(e)..isPendingSync = true;
    await local.addItem(restaurantId, model);

    try {
      await remote.addItem(restaurantId, model);
      model.isPendingSync = false;
      await local.updateItem(restaurantId, model);
    } catch (_) {
      // stays pending
    }
  }

  @override
  Future<void> updateItem(String restaurantId, MenuItemEntity e) async {
    final model = MenuItemModel.fromEntity(e)..isPendingSync = true;
    await local.updateItem(restaurantId, model);

    try {
      await remote.updateItem(restaurantId, model);
      model.isPendingSync = false;
      await local.updateItem(restaurantId, model);
    } catch (_) {}
  }

  @override
  Future<void> deleteItem(String restaurantId, String id) async {
    await local.deleteItem(restaurantId, id);
    try {
      await remote.deleteItem(restaurantId, id);
    } catch (_) {}
  }

  // ✅ NEW: Sync pending Hive items when online
  @override
  Future<void> syncPendingItems(String restaurantId) async {
    final pendingItems = await local.getPendingItems(restaurantId);
    for (final item in pendingItems) {
      try {
        await remote.addItem(restaurantId, item);
        item.isPendingSync = false;
        await local.updateItem(restaurantId, item);
      } catch (_) {
        // If fails again, leave as pending
      }
    }
  }
}
