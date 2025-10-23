import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.brandOrange,
    required this.name,
  });

  final Color brandOrange;
  final String name;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      shadowColor: brandOrange,
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        onPressed: () {
          if (GoRouter.of(context).canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
      ),
      actions: [
        IconButton(
          onPressed: () {
            debugPrint("Notifications tapped");
          },
          icon: Icon(Icons.notifications_on, color: brandOrange),
        ),
      ],
    );
  }
}
