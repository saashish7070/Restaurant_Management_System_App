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

  List<MenuItemEntity> _allItems = [];
  String _searchQuery = '';
  String? _selectedCategory;

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    _applyFilters();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    Iterable<MenuItemEntity> items = _allItems;
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      items = items.where((e) => e.categories.contains(_selectedCategory));
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      items = items.where((e) =>
          e.name.toLowerCase().contains(q) ||
          e.ingredient.toLowerCase().contains(q));
    }
    emit(MenuLoaded(items.toList()));
  }

  Future<void> fetchMenuItems() async {
    emit(MenuLoading());
    try {
      final items = await getMenuItemsUseCase();
      _allItems = items;
      _applyFilters();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> addMenuItem(MenuItemEntity item) async {
    try {
      await addMenuItemUseCase(item);
      _allItems = List<MenuItemEntity>.from(_allItems)..add(item);
      _applyFilters();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> updateMenuItem(MenuItemEntity item) async {
    try {
      await updateMenuItemUseCase(item);
      _allItems = _allItems.map((m) => m.id == item.id ? item : m).toList();
      _applyFilters();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  Future<void> deleteMenuItem(String id) async {
    try {
      await deleteMenuItemUseCase(id);
      _allItems = _allItems.where((m) => m.id != id).toList();
      _applyFilters();
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}
