import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms/core/network/network_info.dart';
import 'data/datasources/menu_local_data_source.dart';
import 'data/datasources/menu_remote_data_source.dart';
import 'data/repositories/menu_repository_impl.dart';
import 'domain/repositories/menu_repository.dart';
import 'domain/usecases/add_menu_item.dart';
import 'domain/usecases/get_menu_items.dart';
import 'domain/usecases/delete_menu_item.dart';
import 'domain/usecases/update_menu_item.dart';
import 'presentation/bloc/menu_cubit.dart';
import 'data/models/menu_item_model.dart';

class MenuInjection {
  static Future<MenuCubit> provideMenuCubit() async {
    // Register Hive Adapter and open box for menu items
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MenuItemModelAdapter());
    }
    final menuBox = await Hive.openBox<MenuItemModel>('menuBox');

    // Network
    final networkInfo = NetworkInfoImpl(Connectivity());

    // Data sources
    final localDataSource = MenuLocalDataSourceImpl(menuBox);
    final remoteDataSource = MenuRemoteDataSourceImpl(FirebaseFirestore.instance);

    // Repository
    final repository = MenuRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );

    // UseCases
    final addUseCase = AddMenuItem(repository);
    final getUseCase = GetMenuItems(repository);
    final deleteUseCase = DeleteMenuItem(repository);
    final updateUseCase = UpdateMenuItem(repository);

    // Cubit
    return MenuCubit(
      addMenuItemUseCase: addUseCase,
      getMenuItemsUseCase: getUseCase,
      deleteMenuItemUseCase: deleteUseCase,
      updateMenuItemUseCase: updateUseCase,
    );
  }

  static Future<MenuRepository> provideMenuRepository() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MenuItemModelAdapter());
    }
    final menuBox = await Hive.openBox<MenuItemModel>('menuBox');

    final networkInfo = NetworkInfoImpl(Connectivity());
    final localDataSource = MenuLocalDataSourceImpl(menuBox);
    final remoteDataSource = MenuRemoteDataSourceImpl(FirebaseFirestore.instance);

    return MenuRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  }
}
