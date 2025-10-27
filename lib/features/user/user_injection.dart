import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:rms/features/user/data/models/user_model.dart';
import 'data/datasources/user_local_data_source.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/user_repository.dart';
import 'domain/usecases/create_user.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/get_logged_in_user.dart';
import 'domain/usecases/logout_user.dart';
import 'presentation/bloc/user_cubit.dart';

Future<UserCubit> initUserFeature() async {
  final firestore = FirebaseFirestore.instance;
  final box = await Hive.openBox<UserModel>('userBox');

  final remote = UserRemoteDataSourceImpl(firestore);
  final local = UserLocalDataSourceImpl(box);
  final repo = UserRepositoryImpl(remote: remote, local: local);

  final createUser = CreateUser(repo);
  final login = LoginUser(repo);
  final getLoggedIn = Ge`tLoggedInUser(repo);
  final logout = LogoutUser(repo);

  return UserCubit(
    createUser: createUser,
    loginUser: login,
    getLoggedInUser: getLoggedIn,
    logoutUser: logout,
  );
}
