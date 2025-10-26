import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms/features/user/domain/entities/user.dart';
import 'package:rms/features/user/domain/usecases/user/get_user.dart';
import 'package:rms/features/user/domain/usecases/user/register_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final RegisterUser registerUser;
  final GetUser getUser;

  UserCubit({required this.registerUser, required this.getUser})
      : super(UserInitial());

  Future<void> register(UserEntity user) async {
    emit(UserLoading());
    try {
      final created = await registerUser(user);
      emit(UserLoaded(created));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> fetchUser(String email) async {
    emit(UserLoading());
    try {
      final fetched = await getUser(email);
      if (fetched != null) {
        emit(UserLoaded(fetched));
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
