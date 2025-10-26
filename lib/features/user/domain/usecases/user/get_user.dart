import 'package:rms/features/user/domain/entities/user.dart';
import 'package:rms/features/user/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);

  Future<UserEntity?> call(String email) async {
    return await repository.getUserByEmail(email);
  }
}
