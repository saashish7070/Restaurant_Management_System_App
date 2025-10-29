import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms/features/menu/presentation/bloc/menu_cubit.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rms/shared/widgets/appbar.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, this.initialItem});

  final MenuItemEntity? initialItem;

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final ingredientController = TextEditingController();

  String? selectedCategory;
  String? selectedCuisine;
  String itemType = 'Veg';
  File? imageFile;
  String? existingImagePath;

  final categories = ['Burger', 'Pizza', 'Momo'];
  final cuisines = ['Italian', 'Chinese', 'Nepali'];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final item = widget.initialItem;
    if (item != null) {
      nameController.text = item.name;
      priceController.text = item.price;
      ingredientController.text = item.ingredient;
      itemType = item.typeItem ? 'Veg' : 'Non Veg';
      selectedCategory = item.categories.isNotEmpty ? item.categories.first : null;
      selectedCuisine = item.cuisine.isNotEmpty ? item.cuisine.first : null;
      existingImagePath = item.imageUrl.isNotEmpty ? item.imageUrl : null;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final file = await picker.pickImage(source: source, imageQuality: 80);
    if (file != null) setState(() => imageFile = File(file.path));
  }

  Future<String?> saveImageLocally(File image) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final newImage = await image.copy(path);
    return newImage.path;
  }

  void showImageDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Image",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _imageOption(Icons.photo_camera, "Camera", ImageSource.camera),
                  _imageOption(Icons.photo_library, "Gallery", ImageSource.gallery),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageOption(IconData icon, String label, ImageSource source) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        pickImage(source);
      },
      child: Column(
        children: [
          Icon(icon, size: 52, color: Colors.black87),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void addCategory() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text("Add New Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter category name",
                  filled: true,
                  fillColor: const Color(0xFFF7F3EC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black87),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          setState(() {
                            categories.add(controller.text);
                            selectedCategory = controller.text;
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7621B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Add",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? savedImagePath;
      if (imageFile != null) {
        savedImagePath = await saveImageLocally(imageFile!);
      }

      final isEdit = widget.initialItem != null;
      final itemId = isEdit ? widget.initialItem!.id : DateTime.now().millisecondsSinceEpoch.toString();

      final item = MenuItemEntity(
        id: itemId,
        name: nameController.text.trim(),
        price: priceController.text.trim(),
        available: isEdit ? widget.initialItem!.available : true,
        cuisine: selectedCuisine != null ? [selectedCuisine!] : <String>[],
        categories: selectedCategory != null ? [selectedCategory!] : <String>[],
        typeItem: itemType == 'Veg',
        imageUrl: savedImagePath ?? existingImagePath ?? '',
        ingredient: ingredientController.text.trim(),
      );

      if (isEdit) {
        await context.read<MenuCubit>().updateMenuItem(item);
      } else {
        await context.read<MenuCubit>().addMenuItem(item);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEdit ? 'Item updated' : 'Item added')),
        );
        context.go('/home');
      }
    }
  }

  Future<void> confirmAndDelete() async {
    final isEdit = widget.initialItem != null;
    if (!isEdit) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete item?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await context.read<MenuCubit>().deleteMenuItem(widget.initialItem!.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item deleted')),
        );
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF2A2A2A);
    const bg = Color(0xFFF9FBFD);
    const brandOrange = Color(0xFFF7621B);

    return Scaffold(
      backgroundColor: bg,
      appBar: const CustomAppBar(
        brandOrange: Color(0xFFF7621B),
        name: "Add New Item",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Item Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            label("Item Name *"),
            field(nameController, "Item Name"),
            const SizedBox(height: 16),
            label("Item Category *"),
            dropdown(selectedCategory, categories, "Select Category",
                (v) => setState(() => selectedCategory = v)),
            const SizedBox(height: 10),
            fullButton("Add New Category", addCategory),
            const SizedBox(height: 16),
            label("Price *"),
            field(priceController, "eg: 1xxx", type: TextInputType.number),
            const SizedBox(height: 16),
            label("Type of Cuisine *"),
            dropdown(selectedCuisine, cuisines, "Select Cuisine",
                (v) => setState(() => selectedCuisine = v)),
            const SizedBox(height: 16),
            label("Ingredients *"),
            field(ingredientController, "Enter Ingredients"),
            const SizedBox(height: 16),
            label("Type of Item *"),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() => itemType = 'Veg'),
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: itemType == 'Veg' ? brandOrange : null,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text("Veg",
                                style: TextStyle(
                                    color: itemType == 'Veg'
                                        ? Colors.white
                                        : Colors.grey.shade300))))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() => itemType = 'Non Veg'),
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: itemType == 'Non Veg' ? brandOrange : null,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text("Non Veg",
                                style: TextStyle(
                                    color: itemType == 'Non Veg'
                                        ? Colors.white
                                        : Colors.grey.shade300))))),
              ]),
            ),
            const SizedBox(height: 16),
            label("Image *"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: showImageDialog,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.shade400, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageFile == null
                    ? (existingImagePath == null
                        ? const Center(
                            child: Icon(Icons.add, size: 40, color: Colors.black))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(File(existingImagePath!), fit: BoxFit.cover)))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(imageFile!, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              if (widget.initialItem != null) ...[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: confirmAndDelete,
                    child: const Text('Delete', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(child: outlineButton("Cancel", () => context.go('/home'))),
              const SizedBox(width: 12),
              Expanded(child: filledButton(widget.initialItem == null ? "Add Item" : "Save Changes", submitForm)),
            ])
          ]),
        ),
      ),
    );
  }

  Widget label(String text) =>
      Text(text, style: const TextStyle(fontWeight: FontWeight.w500));

  Widget field(TextEditingController c, String hint,
      {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: c,
      keyboardType: type,
      validator: (v) => v!.isEmpty ? "Required" : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF7F3EC),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget dropdown(String? value, List<String> list, String hint, Function(String?) onChange) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3EC),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        items: list.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChange,
        decoration: const InputDecoration(border: InputBorder.none),
        hint: Text(hint),
        validator: (v) => v == null ? "Select one" : null,
      ),
    );
  }

  Widget fullButton(String text, VoidCallback onPress) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: onPress,
        child:
            Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget outlineButton(String text, VoidCallback onPress) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16)),
      onPressed: onPress,
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget filledButton(String text, VoidCallback onPress) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16)),
      onPressed: onPress,
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}
