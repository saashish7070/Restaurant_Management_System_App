import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<void> createUser(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      restaurantId: user.restaurantId,
    );
    await remote.createUser(model);
    await local.cacheUser(model);
  }

  @override
  Future<UserEntity?> loginUser(String email, String password) async {
    final userModel = await remote.loginUser(email, password);
    if (userModel != null) {
      await local.cacheUser(userModel);
      return userModel;
    }
    return null;
  }

  @override
  Future<UserEntity?> getLoggedInUser() async {
    return await local.getCachedUser();
  }

  @override
  Future<void> logoutUser() async {
    await local.clearUser();
  }
}
