import '../repositories/menu_repository.dart';
import '../entities/menu_item.dart';

class GetMenu {
  final MenuRepository repo;
  GetMenu(this.repo);

  Future<List<MenuItemEntity>> call(String restaurantId) async {
    return repo.getMenu(restaurantId);
  }
}
