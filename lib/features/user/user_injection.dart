import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms/features/user/data/datasources/user_local_data_source.dart';
import 'package:rms/features/user/data/datasources/user_remote_data_source.dart';
import 'package:rms/features/user/data/models/user_model.dart';
import 'package:rms/features/user/data/repositories/user_repository.dart';
import 'package:rms/features/user/domain/usecases/create_user.dart';
import 'package:rms/features/user/domain/usecases/get_logged_in_user.dart';
import 'package:rms/features/user/domain/usecases/login_user.dart';
import 'package:rms/features/user/domain/usecases/logout_user.dart';
import 'package:rms/features/user/presentation/bloc/user_cubit.dart';

class UserFeature {
  final UserCubit userCubit;
  final UserLocalDataSource userLocal;

  UserFeature({required this.userCubit, required this.userLocal});
}

Future<UserFeature> initUserFeature() async {
  final firestore = FirebaseFirestore.instance;
  final box = await Hive.openBox<UserModel>('userBox');

  final remote = UserRemoteDataSourceImpl(firestore);
  final local = UserLocalDataSourceImpl(box);

  final repository = UserRepositoryImpl(remote: remote, local: local);

  final createUser = CreateUser(repository);
  final loginUser = LoginUser(repository);
  final getLoggedInUser = GetLoggedInUser(repository);
  final logoutUser = LogoutUser(repository);

  final userCubit = UserCubit(
    createUser: createUser,
    loginUser: loginUser,
    getLoggedInUser: getLoggedInUser,
    logoutUser: logoutUser,
  );

  return UserFeature(userCubit: userCubit, userLocal: local);
}
