import 'package:flutter/material.dart';
import 'package:rms/presentation/widgets/appbar.dart';

class OrderTable extends StatelessWidget {
  final String tableNumber;
  const OrderTable({super.key, required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> itemList = [{"ItemName":"Pizza","image":""},{"ItemName":"Spicy","image":""}];
    const Color brandOrange = Color(0xFFF7621B);
    return Scaffold(
      appBar: CustomAppBar(brandOrange: brandOrange, name: tableNumber),
      body: Padding(padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        ),
        itemCount: itemList.length,
        itemBuilder: (context,index){
          final item = itemList[index];
          return Container(
            decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: brandOrange, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['ItemName'],style: TextStyle(fontSize: 24),),
                  ],
                ),
          );
        }),),

    );
  }
}
