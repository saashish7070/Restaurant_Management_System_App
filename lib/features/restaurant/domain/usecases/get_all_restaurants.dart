import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class GetAllRestaurants {
  final RestaurantRepository repository;
  GetAllRestaurants(this.repository);

  Future<List<RestaurantEntity>> call() async {
    return await repository.getAllRestaurants();
  }
}
