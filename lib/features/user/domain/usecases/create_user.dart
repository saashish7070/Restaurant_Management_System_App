import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;
  CreateUser(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.createUser(user);
  }
}
