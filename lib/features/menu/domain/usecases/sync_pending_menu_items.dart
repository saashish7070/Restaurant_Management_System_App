import '../repositories/menu_repository.dart';

class SyncPendingMenuItems {
  final MenuRepository repo;
  SyncPendingMenuItems(this.repo);

  Future<void> call(String restaurantId) async {
    await repo.syncPendingItems(restaurantId);
  }
}
