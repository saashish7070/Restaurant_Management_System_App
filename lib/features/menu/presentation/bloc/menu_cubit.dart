import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/usecases/add_menu_item.dart';
import '../../domain/usecases/get_menu_items.dart';
import '../../domain/usecases/delete_menu_item.dart';
import '../../domain/usecases/update_menu_item.dart';
import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final AddMenuItem addMenuItemUseCase;
  final GetMenuItems getMenuItemsUseCase;
  final DeleteMenuItem deleteMenuItemUseCase;
  final UpdateMenuItem updateMenuItemUseCase;

  MenuCubit({
    required this.addMenuItemUseCase,
    required this.getMenuItemsUseCase,
    required this.deleteMenuItemUseCase,
    required this.updateMenuItemUseCase,
  }) : super(MenuInitial());

  Future<void> fetchMenuItems() async {
    emit(MenuLoading());
    try {
      final items = await getMenuItemsUseCase();
      emit(MenuLoaded(items));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> addMenuItem(MenuItemEntity item) async {
    try {
      await addMenuItemUseCase(item);
      await fetchMenuItems();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> updateMenuItem(MenuItemEntity item) async {
    try {
      await updateMenuItemUseCase(item);
      await fetchMenuItems();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> deleteMenuItem(String id) async {
    try {
      await deleteMenuItemUseCase(id);
      await fetchMenuItems();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}
