import '../repositories/menu_repository.dart';

class DeleteMenuItem {
  final MenuRepository repository;
  DeleteMenuItem(this.repository);

  Future<void> call(String id) async {
    await repository.deleteMenuItem(id);
  }
}
