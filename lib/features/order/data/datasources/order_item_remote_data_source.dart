import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_item_model.dart';

abstract class OrderItemRemoteDataSource {
  Future<void> addOrderItem(String tableNumber, String orderId, OrderItemModel item);
}

class OrderItemRemoteDataSourceImpl implements OrderItemRemoteDataSource {
  final FirebaseFirestore firestore;
  OrderItemRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addOrderItem(String tableNumber, String orderId, OrderItemModel item) async {
    await firestore
        .collection('tables')
        .doc(tableNumber)
        .collection('orders')
        .doc(orderId)
        .collection('items')
        .doc(item.id)
        .set(item.toJson());
  }
}