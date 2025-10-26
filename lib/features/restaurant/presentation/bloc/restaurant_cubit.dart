import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/usecases/create_restaurant.dart';
import '../../domain/usecases/get_all_restaurants.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final CreateRestaurant createRestaurant;
  final GetAllRestaurants getAllRestaurants;

  RestaurantCubit({
    required this.createRestaurant,
    required this.getAllRestaurants,
  }) : super(RestaurantInitial());

  Future<void> addRestaurant(RestaurantEntity restaurant) async {
    emit(RestaurantLoading());
    try {
      final created = await createRestaurant(restaurant);
      emit(RestaurantAdded(created));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  Future<void> loadRestaurants() async {
    emit(RestaurantLoading());
    try {
      final restaurants = await getAllRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }
}
