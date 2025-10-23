import 'package:rms/features/menu/domain/repositories/menu_repository.dart';

class DeleteMenuItem {
  final MenuRepository repo;
  DeleteMenuItem(this.repo);

  Future<void> call(String restaurantId,String id) async{
    return repo.deleteItem(restaurantId, id);
  }
}