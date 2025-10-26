import 'package:rms/features/user/domain/entities/user.dart';


abstract class UserRepository {
  Future<UserEntity> register(UserEntity user);
  Future<UserEntity?> getUserByEmail(String email);
  Future<UserEntity?> getCachedUser();
}
