part of 'restaurant_cubit.dart';

abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}
class RestaurantLoading extends RestaurantState {}

class RestaurantAdded extends RestaurantState {
  final RestaurantEntity restaurant;
  RestaurantAdded(this.restaurant);
}

class RestaurantLoaded extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
}
