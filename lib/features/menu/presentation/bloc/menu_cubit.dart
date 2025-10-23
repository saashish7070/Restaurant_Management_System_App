import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';
import 'package:rms/features/menu/domain/usecases/sync_pending_menu_items.dart';
import '../../domain/usecases/get_menu.dart';
import '../../domain/usecases/add_menu_item.dart';
import '../../domain/usecases/update_menu_item.dart';
import '../../domain/usecases/delete_menu_item.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final GetMenu getMenu;
  final AddMenuItem addItem;
  final UpdateMenuItem updateItem;
  final DeleteMenuItem deleteItem;
  final String restaurantId;
  final SyncPendingMenuItems syncPendingItemsUseCase;


  MenuCubit({
    required this.getMenu,
    required this.addItem,
    required this.updateItem,
    required this.deleteItem,
    required this.restaurantId,
    required this.syncPendingItemsUseCase
  }) : super(MenuInitial());

  /// Load menu items from repository
  Future<void> loadMenu() async {
    emit(MenuLoading());
    try {
      final items = await getMenu(restaurantId);
      emit(MenuLoaded(items));
    } catch (e) {
      emit(MenuError('Failed to load menu: $e'));
    }
  }

  /// Add a new menu item (local first, then remote)
  Future<void> addMenuItem(MenuItemEntity entity) async {
    if (state is! MenuLoaded) return;
    final currentState = state as MenuLoaded;

    final updatedList = List<MenuItemEntity>.from(currentState.items)..add(entity);
    emit(MenuLoaded(updatedList));

    try {
      await addItem(restaurantId, entity);
    } catch (_) {
      // revert on error
      updatedList.removeWhere((e) => e.id == entity.id);
      emit(MenuLoaded(updatedList));
    }
  }

  Future<void> toggleAvailability(String id) async {
    if (state is! MenuLoaded) return;
    final curr = state as MenuLoaded;

    final index = curr.items.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final item = curr.items[index];
    final updated = item.copyWith(available: !item.available);

    final updatedList = List<MenuItemEntity>.from(curr.items);
    updatedList[index] = updated;

    emit(MenuLoaded(updatedList));

    try {
      await updateItem(restaurantId, updated);
    } catch (_) {
      // revert
      updatedList[index] = item;
      emit(MenuLoaded(updatedList));
    }
  }

  Future<void> updateMenuItem(MenuItemEntity entity) async {
    if (state is! MenuLoaded) return;
    final curr = state as MenuLoaded;

    final updatedList = curr.items.map((e) => e.id == entity.id ? entity : e).toList();
    emit(MenuLoaded(updatedList));

    try {
      await updateItem(restaurantId, entity);
    } catch (_) {
      await loadMenu(); // reload from local or remote
    }
  }

  /// Delete a menu item
  Future<void> removeMenuItem(String id) async {
    if (state is! MenuLoaded) return;
    final curr = state as MenuLoaded;
    final updatedList = curr.items.where((e) => e.id != id).toList();
    emit(MenuLoaded(updatedList));

    try {
      await deleteItem(restaurantId, id);
    } catch (_) {
      await loadMenu();
    }
  }

  Future<void> syncPendingItems() async {
  if (state is! MenuLoaded) return;
  emit(MenuSyncing((state as MenuLoaded).items));

  try {
    await syncPendingItemsUseCase(restaurantId);
    await loadMenu(); // refresh after sync
  } catch (_) {
    emit(MenuError("Failed to sync pending items"));
  }
}

}
