import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel?> loginUser(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  UserRemoteDataSourceImpl(this.firestore);

  @override
  Future<UserModel> createUser(UserModel user) async {
    final docRef = firestore.collection('users').doc();
    final userWithId = user.copyWith(id: docRef.id);

    // Only include restaurantId if not null
    await docRef.set(userWithId.toJson());

    return userWithId;
  }

  @override
  Future<UserModel?> loginUser(String email, String password) async {
    final snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromJson(snapshot.docs.first.data());
    }
    return null;
  }
}
