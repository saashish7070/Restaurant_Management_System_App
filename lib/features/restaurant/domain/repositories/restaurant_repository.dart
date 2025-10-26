import '../entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<RestaurantEntity> createRestaurant(RestaurantEntity restaurant);
  Future<List<RestaurantEntity>> getAllRestaurants();
}
