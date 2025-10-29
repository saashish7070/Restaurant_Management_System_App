import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item_model.dart';

abstract class MenuRemoteDataSource {
  Future<void> addMenuItem(MenuItemModel item);
  Future<List<MenuItemModel>> getMenuItems();
  Future<void> deleteMenuItem(String id);
  Future<void> updateMenuItem(MenuItemModel item);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final FirebaseFirestore firestore;
  MenuRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addMenuItem(MenuItemModel item) async {
    await firestore.collection('menu').doc(item.id).set(item.toJson());
  }

  @override
  Future<List<MenuItemModel>> getMenuItems() async {
    final snapshot = await firestore.collection('menu').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      // Ensure the Firestore document id is used if not stored in the document
      final withId = {
        ...data,
        'id': data['id'] ?? doc.id,
      };
      return MenuItemModel.fromJson(withId);
    }).toList();
  }

  @override
  Future<void> deleteMenuItem(String id) async {
    await firestore.collection('menu').doc(id).delete();
  }

  @override
  Future<void> updateMenuItem(MenuItemModel item) async {
    await firestore.collection('menu').doc(item.id).update(item.toJson());
  }
}
