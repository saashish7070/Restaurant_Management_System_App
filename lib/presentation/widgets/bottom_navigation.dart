
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavBar {
  static final PersistentTabController controller = PersistentTabController(initialIndex: 0);

  static List<PersistentBottomNavBarItem> items(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded),title: "Home",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu_book),title: "Menu",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dinner_dining_rounded),title: "Order",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        ) ,
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),title: "Profile",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        )  
    ];
  }
}