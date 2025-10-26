import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_local_data_source.dart';
import '../datasources/restaurant_remote_data_source.dart';
import '../models/restaurant_model.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remote;
  final RestaurantLocalDataSource local;

  RestaurantRepositoryImpl({required this.remote, required this.local});

  @override
  Future<RestaurantEntity> createRestaurant(RestaurantEntity restaurant) async {
    final model = RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      location: restaurant.location,
      menuId: restaurant.menuId,
      orderId: restaurant.orderId,
    );

    final created = await remote.createRestaurant(model);
    final existing = await local.getCachedRestaurants();
    existing.add(created);
    await local.cacheRestaurants(existing);

    return created;
  }

  @override
  Future<List<RestaurantEntity>> getAllRestaurants() async {
    try {
      final remoteList = await remote.getAllRestaurants();
      await local.cacheRestaurants(remoteList);
      return remoteList;
    } catch (_) {
      return await local.getCachedRestaurants();
    }
  }
}
