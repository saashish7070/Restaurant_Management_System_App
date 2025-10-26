import 'package:rms/features/user/data/datasources/user/user_local_datasource.dart';
import 'package:rms/features/user/data/datasources/user/user_remote_datasource.dart';
import 'package:rms/features/user/data/models/user_model.dart';
import 'package:rms/features/user/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl({required this.remote, required this.local});

  @override
  Future<UserEntity> register(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      restaurantId: user.restaurantId,
    );
    final createdUser = await remote.createUser(model);
    await local.cacheUser(createdUser);
    return createdUser;
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    final user = await remote.getUserByEmail(email);
    if (user != null) await local.cacheUser(user);
    return user;
  }

  @override
  Future<UserEntity?> getCachedUser() => local.getCachedUser();
}
