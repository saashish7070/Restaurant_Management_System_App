import 'package:hive/hive.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantLocalDataSource {
  Future<void> cacheRestaurants(List<RestaurantModel> restaurants);
  Future<List<RestaurantModel>> getCachedRestaurants();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final Box box;
  RestaurantLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheRestaurants(List<RestaurantModel> restaurants) async {
    final jsonList = restaurants.map((r) => r.toJson()).toList();
    await box.put('cached_restaurants', jsonList);
  }

  @override
  Future<List<RestaurantModel>> getCachedRestaurants() async {
    final data = box.get('cached_restaurants');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data)
        .map((json) => RestaurantModel.fromJson(json))
        .toList();
  }
}
