import 'package:hive/hive.dart';
import 'package:rms/features/user/data/models/user_model.dart';


abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCachedUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;
  UserLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheUser(UserModel user) async {
    await box.put('cached_user', user.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final data = box.get('cached_user');
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<void> clearCachedUser() async => await box.delete('cached_user');
}
