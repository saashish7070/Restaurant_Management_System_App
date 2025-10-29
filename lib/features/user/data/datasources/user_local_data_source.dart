import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getUser(String id);
  Future<void> clearUser();
  Future<UserModel?> getCachedUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserModel> box;
  UserLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheUser(UserModel user) async {
    await box.put('logged_in_user', user); // store under single key
  }

  @override
  Future<UserModel?> getUser(String id) async {
    return box.get(id);
  }

  @override
  Future<void> clearUser() async {
    await box.delete('logged_in_user');
  }

  @override
  Future<UserModel?> getCachedUser() async {
    return box.get('logged_in_user');
  }
}
