import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms/features/order/domain/entities/order_entity';
import 'package:rms/features/menu/presentation/bloc/menu_cubit.dart';
import '../bloc/order_bloc.dart';

class MenuSelectionScreen extends StatelessWidget {
  final String tableNumber;
  const MenuSelectionScreen({super.key, required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();

    return FutureBuilder(
      future: menuCubit.getMenuItemsUseCase(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final menuItems = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text("Menu")),
          body: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return ListTile(
                leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item.name),
                subtitle: Text("Rs. ${item.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: () {
                    context.read<OrderBloc>().add(
                      AddItemToCart(
                        OrderItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          menuItemId: item.id,
                          name: item.name,
                          quantity: 1,
                          price: double.tryParse(item.price) ?? 0,
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item.name} added to Table $tableNumber")));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
