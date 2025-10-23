import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item_model.dart';

abstract class RemoteMenuDataSource {
  Future<List<MenuItemModel>> fetchMenu(String restaurantId);
  Future<void> addItem(String restaurantId, MenuItemModel item);
  Future<void> updateItem(String restaurantId, MenuItemModel item);
  Future<void> deleteItem(String restaurantId, String id);
}

class RemoteMenuDataSourceImpl implements RemoteMenuDataSource {
  final FirebaseFirestore firestore;
  RemoteMenuDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _itemsRef(String restaurantId) {
    return firestore.collection('menus').doc(restaurantId).collection('items');
  }

  @override
  Future<List<MenuItemModel>> fetchMenu(String restaurantId) async {
    final snap = await _itemsRef(restaurantId).get();
    return snap.docs.map((d) {
      final m = MenuItemModel.fromJson(d.data());
      return m;
    }).toList();
  }

  @override
  Future<void> addItem(String restaurantId, MenuItemModel item) async {
    await _itemsRef(restaurantId).doc(item.id).set(item.toJson());
  }

  @override
  Future<void> updateItem(String restaurantId, MenuItemModel item) async {
    await _itemsRef(restaurantId).doc(item.id).update(item.toJson());
  }

  @override
  Future<void> deleteItem(String restaurantId, String id) async {
    await _itemsRef(restaurantId).doc(id).delete();
  }
}
