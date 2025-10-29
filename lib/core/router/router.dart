import 'package:go_router/go_router.dart';
import 'package:rms/features/order/presentation/screens/order_screen.dart';
import 'package:rms/features/order/presentation/screens/menu_selection_screen.dart';
import 'package:rms/features/order/presentation/screens/order_table_screen.dart';
import 'package:rms/features/user/presentation/screens/home.dart';
import 'package:rms/features/user/presentation/screens/login.dart';
import 'package:rms/features/user/presentation/screens/signup.dart';
import 'package:rms/shared/widgets/menu/new_item.dart';
import 'package:rms/features/menu/presentation/screens/edit_item.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    /// ---------- USER FLOW ----------
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    /// ---------- MENU FLOW ----------
    // Show list of items to edit
    GoRoute(
      path: '/editItem',
      builder: (context, state) => const EditItemScreen(),
    ),
    // New item creation
    GoRoute(
      path: '/newItem',
      builder: (context, state) {
        final item = state.extra as MenuItemEntity?;
        return NewItem(initialItem: item);
      },
    ),

    /// ---------- ORDER FLOW ----------
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: '/order/:tableNumber',
      builder: (context, state) {
        final tableNumber = state.pathParameters['tableNumber'];
        return OrderTableScreen(tableNumber: tableNumber ?? '1');
      },
    ),
    GoRoute(
      path: '/menu/:tableNumber',
      builder: (context, state) {
        final tableNumber = state.pathParameters['tableNumber'] ?? '1';
        return MenuSelectionScreen(tableNumber: tableNumber);
      },
    ),
  ],
);
