import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/user/user_injection.dart';
import 'features/user/presentation/bloc/user_cubit.dart';
import 'core/router/router.dart';
import 'features/user/data/models/user_model.dart';
import 'features/menu/menu_injection.dart';
import 'features/menu/presentation/bloc/menu_cubit.dart';
import 'features/order/order_injection.dart';
import 'features/order/presentation/bloc/order_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter()); // only UserModel now

  await Hive.openBox<UserModel>('userBox');

  final userFeature = await initUserFeature(); // returns UserFeature
  final menuCubit = await MenuInjection.provideMenuCubit();
  final menuRepository = await MenuInjection.provideMenuRepository();
  final orderBloc = await OrderInjection.provideOrderBloc(menuRepository);

  await dotenv.load(fileName: "assets/.env");

  runApp(MyApp(userCubit: userFeature.userCubit, menuCubit: menuCubit, orderBloc: orderBloc));
}

class MyApp extends StatelessWidget {
  final UserCubit userCubit;
  final MenuCubit menuCubit;
  final OrderBloc orderBloc;

  const MyApp({super.key, required this.userCubit, required this.menuCubit, required this.orderBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>.value(value: userCubit),
        BlocProvider<MenuCubit>.value(value: menuCubit),
        BlocProvider<OrderBloc>.value(value: orderBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SwadKhoj',
        routerConfig: appRouter,
      ),
    );
  }
}
