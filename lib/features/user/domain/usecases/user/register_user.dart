import 'package:rms/features/user/domain/entities/user.dart';
import 'package:rms/features/user/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;
  RegisterUser(this.repository);

  Future<UserEntity> call(UserEntity user) async {
    return await repository.register(user);
  }
}
