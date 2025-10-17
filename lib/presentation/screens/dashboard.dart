import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFF7621B);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        shadowColor: brandOrange,
        title: Center(
          child: const Text(
            "SwadKhoj",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
          },
          icon: const Icon(Icons.menu, color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.notifications_on,
              color: brandOrange,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Dashboard",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
