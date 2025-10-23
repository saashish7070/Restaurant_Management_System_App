import 'package:rms/features/menu/domain/entities/menu_item.dart';
import 'package:rms/features/menu/domain/repositories/menu_repository.dart';

class UpdateMenuItem {
  final MenuRepository repo;
  UpdateMenuItem(this.repo);

  Future<void> call(String restaurantId,MenuItemEntity item) async{
    return repo.updateItem(restaurantId, item);
  }
}