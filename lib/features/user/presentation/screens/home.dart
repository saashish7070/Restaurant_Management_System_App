import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:rms/features/order/presentation/screens/order_screen.dart';
import 'package:rms/features/user/presentation/screens/dashboard.dart';
import 'package:rms/features/menu/presentation/screens/menu.dart';
import 'package:rms/features/user/presentation/screens/profile.dart';
import 'package:rms/shared/widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Widget> _buildScreens(){
    return [
      DashboardScreen(),
      MenuScreen(),
      OrderScreen(),
      ProfileScreen()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,controller: BottomNavBar.controller, screens: _buildScreens(),
    items: BottomNavBar.items(),navBarStyle: NavBarStyle.style6);
    }
}