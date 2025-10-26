import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class CreateRestaurant {
  final RestaurantRepository repository;
  CreateRestaurant(this.repository);

  Future<RestaurantEntity> call(RestaurantEntity restaurant) async {
    return await repository.createRestaurant(restaurant);
  }
}
