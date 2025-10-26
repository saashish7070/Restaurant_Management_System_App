// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:rms/features/menu/data/models/menu_item_model.dart';

// Future<void> main() async {
//   print('Initializing Hive...');
//   await Hive.initFlutter();

//   // Register your adapter
//   Hive.registerAdapter(MenuItemModelAdapter());

//   // Open a test box
//   var box = await Hive.openBox<MenuItemModel>('testBox');
//   print('Hive box opened successfully.');

//   // Create a test object
//   var testItem = MenuItemModel(
//     id: '1',
//     name: 'Pizza',
//     price: '250',
//     available: true,
//     cuisine: ['Italian'],
//     categories: ['Fast Food'],
//     typeItem: true,
//     imageUrl: 'https://example.com/pizza.png',
//     ingredient: 'Cheese, Tomato, Dough',
//   );

//   // Add item
//   await box.put(testItem.id, testItem);
//   print('Item written to Hive.');

//   // Retrieve item
//   final fetched = box.get('1');
//   print('Fetched item: ${fetched?.name} - ${fetched?.price}');

//   // List all values
//   print('All items in box:');
//   for (var i in box.values) {
//     print('➡️ ${i.name} (${i.price})');
//   }

//   await box.close();
//   print('Hive connection test completed ✅');
// }