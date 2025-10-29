// import 'package:flutter/material.dart';
// import 'package:rms/shared/widgets/appbar.dart';
// import 'package:rms/shared/widgets/order/order_summary_bottom_sheet.dart';

// class OrderTable extends StatefulWidget {
//   final String tableNumber;
//   const OrderTable({super.key, required this.tableNumber});

//   @override
//   State<OrderTable> createState() => _OrderTableState();
// }

// class _OrderTableState extends State<OrderTable> {
//   String seatStatus = 'Empty'; // "Empty" or "Seated"

//   final Color brandOrange = const Color(0xFFF7621B);
//   final Color black = Colors.black;

//   final List<Map<String, dynamic>> itemList = [
//     {
//       "ItemName": "Pizza",
//       "image":
//           "https://www.tasteofhome.com/wp-content/uploads/2018/01/Homemade-Pizza_EXPS_FT23_376_EC_120123_3.jpg",
//       "quantity": 1,
//     },
//     {
//       "ItemName": "Burger",
//       "image":
//           "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQsUChVfSK66TNo0Mwny0jCVEqNo-kK7LXFOWtZlkzc3TQ3VNidEpt9lUYY-7ADuHG-qCkMa-Nb5Y6EosjEC9fttPM5qL-tshn3vjBoiQ",
//       "quantity": 1,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(brandOrange: brandOrange, name: widget.tableNumber),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: GridView.builder(
//           itemCount: itemList.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.8,
//           ),
//           itemBuilder: (context, index) {
//             final item = itemList[index];
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: brandOrange, width: 2),
//                 boxShadow: [
//                   BoxShadow(
//                     // ignore: deprecated_member_use
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(14),
//                       ),
//                       child: Image.network(
//                         item['image'],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Center(
//                       child: Text(
//                         item['ItemName'],
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: null, // logic via Cubit later
//                             icon: const Icon(Icons.remove_circle_outline),
//                             iconSize: 36,
//                             color: Colors.redAccent,
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(
//                               minWidth: 40,
//                               minHeight: 40,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           const Text(
//                             '1', // will come from Cubit later
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w800,
//                               color: Color(0xFFF7621B),
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           IconButton(
//                             onPressed: null, // logic via Cubit later
//                             icon: const Icon(Icons.add_circle_outline),
//                             iconSize: 36,
//                             color: Colors.green,
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(
//                               minWidth: 40,
//                               minHeight: 40,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(12,0,12,42),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 height: 50, 
//                 decoration: BoxDecoration(
//                   color: black,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: const EdgeInsets.all(2),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => seatStatus = 'Empty'),
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: seatStatus == 'Empty' ? brandOrange : null,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Text(
//                             "Empty",
//                             style: TextStyle(
//                               color: seatStatus == 'Empty'
//                                   ? Colors.white
//                                   : Colors.grey.shade300,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => seatStatus = 'Seated'),
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: seatStatus == 'Seated' ? brandOrange : null,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Text(
//                             "Seated",
//                             style: TextStyle(
//                               color: seatStatus == 'Seated'
//                                   ? Colors.white
//                                   : Colors.grey.shade300,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 32),
//             Expanded(
//               flex: 1,
//               child: SizedBox(
//                 height: 50, 
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                       ),
//                       builder: (context) {
//                         final selectedItems = [
//                           {"ItemName": "Pizza", "quantity": 2},
//                           {"ItemName": "Burger", "quantity": 1},
//                         ];
//                         return OrderSummaryBottomSheet(
//                           selectedItems: selectedItems,
//                           onConfirm: () {
                           
//                           },
//                         );
//                       },
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: brandOrange,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white,size: 24,),
//                   label: const Text(
//                     'Place Order',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
// );
//   }
// }
