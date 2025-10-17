import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final bool editEnable;
  const ItemList({super.key, required this.editEnable});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final List<Map<String, dynamic>> items = [
    {"name": "Burger", "price": 120, "available": true},
    {"name": "Pizza", "price": 350, "available": false},
    {"name": "Momo", "price": 150, "available": true},
    {"name": "Chowmein", "price": 180, "available": true},
    {"name": "Sandwich", "price": 200, "available": false},
  ];

  late bool editEnable;

  @override
  void initState() {
    super.initState();
    editEnable = widget.editEnable;
  }

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFF7621B);

    return Column(
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Dish Name
              Expanded(
                flex: 2,
                child: Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              // Price
              Expanded(
                flex: 1,
                child: Text(
                  "Rs ${item['price']}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
  flex: 1,
  child: SizedBox(
    height: 40, // same height for both Switch and Edit button
    child: !editEnable
        ? Switch(
            value: item['available'],
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                item['available'] = value;
              });
            },
          )
        : InkWell(
            onTap: () {
              // handle edit logic here
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: brandOrange,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
  ),
),

            ],
          ),
        );
      }).toList(),
    );
  }
}
