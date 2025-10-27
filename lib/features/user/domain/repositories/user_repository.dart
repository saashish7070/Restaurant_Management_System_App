import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser(UserEntity user);
  Future<UserEntity?> loginUser(String email, String password);
  Future<UserEntity?> getLoggedInUser();
  Future<void> logoutUser();
}
