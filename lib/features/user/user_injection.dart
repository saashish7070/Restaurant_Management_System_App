import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:rms/features/user/data/datasources/user/user_local_datasource.dart';
import 'package:rms/features/user/data/datasources/user/user_remote_datasource.dart';
import 'package:rms/features/user/data/repositories/user_repository.dart';
import 'package:rms/features/user/domain/usecases/user/get_user.dart';
import 'package:rms/features/user/domain/usecases/user/register_user.dart';
import 'package:rms/features/user/presentation/bloc/user/user_cubit.dart';

Future<UserCubit> initUserFeature() async {
  final firestore = FirebaseFirestore.instance;
  final box = await Hive.openBox('userBox');

  final remote = UserRemoteDataSourceImpl(firestore);
  final local = UserLocalDataSourceImpl(box);
  final repo = UserRepositoryImpl(remote: remote, local: local);
  final registerUser = RegisterUser(repo);
  final getUser = GetUser(repo);

  return UserCubit(registerUser: registerUser, getUser: getUser);
}
