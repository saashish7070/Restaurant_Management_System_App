import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_local_data_source.dart';
import '../datasources/menu_remote_data_source.dart';
import '../models/menu_item_model.dart';
import '../../../../core/network/network_info.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;
  final MenuLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MenuRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> addMenuItem(MenuItemEntity entity) async {
    final model = MenuItemModel.fromEntity(entity);
    if (await networkInfo.isConnected) {
      await remoteDataSource.addMenuItem(model);
      await localDataSource.cacheMenuItem(model);
    } else {
      await localDataSource.cacheMenuItem(model);
    }
  }

  @override
  Future<List<MenuItemEntity>> getMenuItems() async {
    if (await networkInfo.isConnected) {
      final models = await remoteDataSource.getMenuItems();
      for (var item in models) {
        await localDataSource.cacheMenuItem(item);
      }
      return models.map((e) => e.toEntity()).toList();
    } else {
      final cached = await localDataSource.getCachedMenuItems();
      return cached.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<void> deleteMenuItem(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteMenuItem(id);
    }
    await localDataSource.deleteCachedMenuItem(id);
  }

  @override
  Future<void> updateMenuItem(MenuItemEntity entity) async {
    final model = MenuItemModel.fromEntity(entity);
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateMenuItem(model);
    }
    await localDataSource.updateCachedMenuItem(model);
  }
}
