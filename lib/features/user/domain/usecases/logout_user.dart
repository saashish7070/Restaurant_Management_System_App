import '../repositories/user_repository.dart';

class LogoutUser {
  final UserRepository repository;
  LogoutUser(this.repository);

  Future<void> call() async {
    await repository.logoutUser();
  }
}
