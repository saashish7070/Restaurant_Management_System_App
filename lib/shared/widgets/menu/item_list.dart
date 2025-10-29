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

  Future<void> _showEditDialog(BuildContext context, MenuItemEntity item) async {
    final TextEditingController nameController =
        TextEditingController(text: item.name);
    final TextEditingController priceController =
        TextEditingController(text: item.price);
    final TextEditingController ingredientController =
        TextEditingController(text: item.ingredient);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const Color brandOrange = Color(0xFFF7621B);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 10,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titlePadding: const EdgeInsets.only(left: 20, right: 8, top: 16, bottom: 4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.restaurant_menu, color: brandOrange, size: 26),
                  SizedBox(width: 10),
                  Text(
                    "Edit Menu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              // Delete Icon Button
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 26),
                tooltip: "Delete item",
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text("Delete Menu Item"),
                      content: Text(
                        "Are you sure you want to delete '${item.name}'?",
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text("Cancel",style: TextStyle(color: Colors.black),),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text("Delete",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    context.read<MenuCubit>().deleteMenuItem(item.id);
                    Navigator.pop(context); // Close edit dialog after delete
                  }
                },
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name Field
                    TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: "Item Name",
                        prefixIcon:
                            const Icon(Icons.fastfood, color: brandOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: brandOrange, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) =>
                          value?.trim().isEmpty ?? true
                              ? "Name is required"
                              : null,
                    ),
                    const SizedBox(height: 16),

                    // Price Field
                    TextFormField(
                      controller: priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: "Price (Rs)",
                        prefixIcon:
                            const Icon(Icons.attach_money, color: brandOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: brandOrange, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Price is required";
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return "Invalid price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ingredients Field
                    TextFormField(
                      controller: ingredientController,
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: "Ingredients",
                        alignLabelWithHint: true,
                        prefixIcon:
                            const Icon(Icons.kitchen, color: brandOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: brandOrange, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) =>
                          value?.trim().isEmpty ?? true
                              ? "Ingredients are required"
                              : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
            ),
            // Save Button
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final updatedItem = MenuItemEntity(
                    id: item.id,
                    name: nameController.text.trim(),
                    price: priceController.text.trim(),
                    available: item.available,
                    cuisine: item.cuisine,
                    categories: item.categories,
                    typeItem: item.typeItem,
                    imageUrl: item.imageUrl,
                    ingredient: ingredientController.text.trim(),
                  );
                  context.read<MenuCubit>().updateMenuItem(updatedItem);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brandOrange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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

        final items =
            state is MenuLoaded ? state.menuItems : <MenuItemEntity>[];
        if (items.isEmpty) {
          return const Center(child: Text('No items'));
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: items.map((item) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
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
                                  context
                                      .read<MenuCubit>()
                                      .updateMenuItem(updated);
                                },
                              )
                            : InkWell(
                                onTap: () => _showEditDialog(context, item),
                                child: const Icon(
                                  Icons.edit,
                                  color: brandOrange,
                                  size: 30,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
