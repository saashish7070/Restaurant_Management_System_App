import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUser(UserModel user);
  Future<UserModel?> loginUser(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  UserRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
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
