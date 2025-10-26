import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms/features/user/data/models/user_model.dart';


abstract class UserRemoteDataSource {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel?> getUserByEmail(String email);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  UserRemoteDataSourceImpl(this.firestore);

  @override
  Future<UserModel> createUser(UserModel user) async {
    final docRef = firestore.collection('users').doc(user.id);
    await docRef.set(user.toJson());
    return user;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final query =
        await firestore.collection('users').where('email', isEqualTo: email).get();
    if (query.docs.isEmpty) return null;
    return UserModel.fromJson(query.docs.first.data());
  }
}
