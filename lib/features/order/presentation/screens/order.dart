// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rms/shared/widgets/appbar.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final tables = List.generate(10, (index) => index + 1); 
//     const Color brandOrange = Color(0xFFF7621B);

//     return Scaffold(
//       appBar: CustomAppBar(brandOrange: brandOrange, name: "Orders"),

//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, 
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             childAspectRatio: 1, 
//           ),
//           itemCount: tables.length,
//           itemBuilder: (context, index) {
//             final tableNumber = tables[index];

//             return GestureDetector(
//               onTap: () {
//                 context.go('/order/$tableNumber');
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: brandOrange, width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       // ignore: deprecated_member_use
//                       color: Colors.grey.withOpacity(0.2),
//                       blurRadius: 6,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
                    
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.asset(
//                           'assets/images/table.jpg', 
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
                    
//                     Text(
//                       "Table $tableNumber",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: brandOrange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
