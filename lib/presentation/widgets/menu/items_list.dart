import 'package:flutter/material.dart';
import 'package:rms/presentation/widgets/menu/item_list.dart';

class ItemsList extends StatelessWidget {
  final bool editEnable; 
  final String action;

  const ItemsList({
    super.key,
    required this.editEnable,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFF293035);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: brandOrange,
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Dish Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$action",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          ItemList(editEnable: editEnable),
        ],
      ),
    );
  }
}
