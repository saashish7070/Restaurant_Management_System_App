import '../entities/menu_item.dart';
import '../repositories/menu_repository.dart';

class AddMenuItem {
  final MenuRepository repository;
  AddMenuItem(this.repository);

  Future<void> call(MenuItemEntity item) async {
    await repository.addMenuItem(item);
  }
}
