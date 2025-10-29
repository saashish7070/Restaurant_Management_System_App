import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:rms/features/menu/presentation/bloc/menu_state.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';

class ItemList extends StatefulWidget {
  final bool editEnable;
  const ItemList({super.key, required this.editEnable});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late bool editEnable;

  @override
  void initState() {
    super.initState();
    editEnable = widget.editEnable;
    context.read<MenuCubit>().fetchMenuItems();
  }

  void _showEditDialog(BuildContext context, MenuItemEntity item) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price);
    final descController = TextEditingController(text: item.ingredient);

    const Color brandOrange = Color(0xFFF7621B);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Edit Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: brandOrange),
              onPressed: () {
                final updatedItem = MenuItemEntity(
                  id: item.id,
                  name: nameController.text.trim(),
                  price: priceController.text.trim(),
                  available: item.available,
                  cuisine: item.cuisine,
                  categories: item.categories,
                  typeItem: item.typeItem,
                  imageUrl: item.imageUrl,
                  ingredient: descController.text.trim(),
                );

                context.read<MenuCubit>().updateMenuItem(updatedItem);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFF7621B);

    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is MenuLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MenuError) {
          return Center(child: Text(state.message));
        }

        final items = state is MenuLoaded ? state.menuItems : <MenuItemEntity>[];
        if (items.isEmpty) {
          return const Center(child: Text('No items'));
        }

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
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Rs ${item.price}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: !editEnable
                          ? Switch(
                              value: item.available,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                final updated = MenuItemEntity(
                                  id: item.id,
                                  name: item.name,
                                  price: item.price,
                                  available: value,
                                  cuisine: item.cuisine,
                                  categories: item.categories,
                                  typeItem: item.typeItem,
                                  imageUrl: item.imageUrl,
                                  ingredient: item.ingredient,
                                );
                                context.read<MenuCubit>().updateMenuItem(updated);
                              },
                            )
                          : InkWell(
                              onTap: () => _showEditDialog(context, item),
                              child: const Icon(
                                Icons.edit,
                                color: brandOrange,
                                size: 32,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
