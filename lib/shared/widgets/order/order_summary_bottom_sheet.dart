import 'package:flutter/material.dart';

class OrderSummaryBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final VoidCallback onConfirm;

  const OrderSummaryBottomSheet({
    super.key,
    required this.selectedItems,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFF7621B);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Selected Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // List of selected items
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedItems.length,
            itemBuilder: (context, index) {
              final item = selectedItems[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.fastfood, color: brandOrange),
                title: Text(
                  item['ItemName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  'x${item['quantity']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Confirm Order button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pop(context); // close bottom sheet
                onConfirm(); // callback for order placement
              },
              child: const Text(
                'Confirm Order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
