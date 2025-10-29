import 'package:flutter/material.dart';
import 'package:rms/shared/widgets/appbar.dart';
import 'package:rms/shared/widgets/menu/item_list.dart';
import 'package:rms/shared/widgets/menu/search_dish.dart';
import 'package:rms/shared/widgets/menu/select_category.dart';

class EditItemScreen extends StatelessWidget {
  const EditItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    const Color brandOrange = Color(0xFFF7621B);
    return Scaffold(
      appBar: CustomAppBar(brandOrange: brandOrange, name: "Edit Item"),
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
            const ItemList(editEnable: true),
          ],
        ),
      ),
    );
  }
}