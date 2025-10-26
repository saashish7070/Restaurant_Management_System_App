import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<RestaurantModel> createRestaurant(RestaurantModel restaurant);
  Future<List<RestaurantModel>> getAllRestaurants();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final FirebaseFirestore firestore;
  RestaurantRemoteDataSourceImpl(this.firestore);

  @override
  Future<RestaurantModel> createRestaurant(RestaurantModel restaurant) async {
    final doc = firestore.collection('restaurants').doc(restaurant.id);
    await doc.set(restaurant.toJson());
    return restaurant;
  }

  @override
  Future<List<RestaurantModel>> getAllRestaurants() async {
    final snapshot = await firestore.collection('restaurants').get();
    return snapshot.docs
        .map((doc) => RestaurantModel.fromJson(doc.data()))
        .toList();
  }
}
