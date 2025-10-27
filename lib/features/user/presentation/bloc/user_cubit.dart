import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/get_logged_in_user.dart';
import '../../domain/usecases/logout_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CreateUser createUser;
  final LoginUser loginUser;
  final GetLoggedInUser getLoggedInUser;
  final LogoutUser logoutUser;

  UserCubit({
    required this.createUser,
    required this.loginUser,
    required this.getLoggedInUser,
    required this.logoutUser,
  }) : super(UserInitial());

  Future<void> register(UserEntity user) async {
    emit(UserLoading());
    try {
      await createUser(user);
      emit(UserRegistered());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(UserLoading());
    try {
      final user = await loginUser(email, password);
      if (user != null) {
        emit(UserLoggedIn(user));
      } else {
        emit(UserError("Invalid email or password"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> loadLoggedInUser() async {
    final user = await getLoggedInUser();
    if (user != null) {
      emit(UserLoggedIn(user));
    }
  }

  Future<void> logout() async {
    await logoutUser();
    emit(UserLoggedOut());
  }
}
