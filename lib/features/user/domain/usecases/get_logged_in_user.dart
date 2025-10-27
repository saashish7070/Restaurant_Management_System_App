import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetLoggedInUser {
  final UserRepository repository;
  GetLoggedInUser(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getLoggedInUser();
  }
}
