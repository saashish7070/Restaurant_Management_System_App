import 'package:flutter/material.dart';

class RestaurantManagementList extends StatelessWidget {
  const RestaurantManagementList({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFF7621B);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16,),
        const Text(
          "Restaurant Management",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.storefront_sharp,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Switch to Restaurant Management",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(Icons.repeat_rounded,size: 32,color: brandOrange,)
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.people_outline_rounded,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Manage Staff Admin",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_circle_right_outlined,size: 32,)
          ],
        ),
      ],
    );
  }
}