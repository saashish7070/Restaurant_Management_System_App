import '../repositories/menu_repository.dart';
import '../entities/menu_item.dart';

class AddMenuItem {
  final MenuRepository repo;
  AddMenuItem(this.repo);

  Future<void> call(String restaurantId, MenuItemEntity item) async {
    return repo.addItem(restaurantId, item);
  }
}
