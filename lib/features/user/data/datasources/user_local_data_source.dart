import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserModel> box;
  UserLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheUser(UserModel user) async {
    await box.put('user', user);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    return box.get('user');
  }

  @override
  Future<void> clearUser() async {
    await box.delete('user');
  }
}
