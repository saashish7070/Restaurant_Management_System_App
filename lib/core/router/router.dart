import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rms/presentation/screens/home.dart';
import 'package:rms/presentation/screens/login.dart';
import 'package:rms/presentation/screens/edit_item.dart';
import 'package:rms/presentation/screens/ordertable.dart';
import 'package:rms/presentation/widgets/menu/new_item.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/editItem',
      builder: (context, state) => const EditItemScreen(),
    ),
    GoRoute(
      path: '/newItem',
      builder: (context, state) => const NewItem(),
    ),
    GoRoute(
  path: '/order/:tableNumber',
  builder: (context, state) {
    final tableNumber = state.pathParameters['tableNumber'];
    return OrderTable(tableNumber: "Table $tableNumber"!);
  },
),


  ],
);
