import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'data/datasources/restaurant_local_data_source.dart';
import 'data/datasources/restaurant_remote_data_source.dart';
import 'data/repositories/restaurant_repository_impl.dart';
import 'domain/usecases/create_restaurant.dart';
import 'domain/usecases/get_all_restaurants.dart';
import 'presentation/bloc/restaurant_cubit.dart';

Future<RestaurantCubit> initRestaurantFeature() async {
  final firestore = FirebaseFirestore.instance;
  final box = await Hive.openBox('restaurantBox');

  final remote = RestaurantRemoteDataSourceImpl(firestore);
  final local = RestaurantLocalDataSourceImpl(box);
  final repo = RestaurantRepositoryImpl(remote: remote, local: local);

  final createRestaurant = CreateRestaurant(repo);
  final getAllRestaurants = GetAllRestaurants(repo);

  return RestaurantCubit(
    createRestaurant: createRestaurant,
    getAllRestaurants: getAllRestaurants,
  );
}
