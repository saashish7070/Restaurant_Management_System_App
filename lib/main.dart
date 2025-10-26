import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/firebase_service.dart';
import 'core/network/hive_service.dart';
import 'core/router/router.dart';
import 'features/menu/data/models/menu_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.initialize();

  await HiveService.init();
  Hive.registerAdapter(MenuItemModelAdapter());
  await Hive.openBox('menuBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SwadKhoj',
      routerConfig: appRouter,
    );
  }
}
