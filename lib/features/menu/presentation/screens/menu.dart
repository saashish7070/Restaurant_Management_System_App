import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rms/shared/widgets/appbar.dart';
import 'package:rms/shared/widgets/menu/items_list.dart';
import 'package:rms/shared/widgets/menu/search_dish.dart';
import 'package:rms/shared/widgets/menu/select_category.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController searchController = TextEditingController();
  final Color brandOrange = const Color(0xFFF7621B);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        brandOrange: brandOrange,
        name: "Menu",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchDish(
              searchController: searchController,
              brandOrange: brandOrange,
            ),
            const SizedBox(height: 20),
            const CategorySelector(),
            ItemsList(editEnable: false,action: "Available"),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              context.go(
                '/editItem',
                extra: {'editEnable': true},
              );
            },
            backgroundColor: brandOrange,
            elevation: 12,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.edit,
              size: 38,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
