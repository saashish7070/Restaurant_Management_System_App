import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/orders_entity_model.dart';

abstract class OrdersEntityRemoteDataSource {
  Future<void> addOrder(String tableNumber, OrdersEntityModel order);
}

class OrdersEntityRemoteDataSourceImpl implements OrdersEntityRemoteDataSource {
  final FirebaseFirestore firestore;
  OrdersEntityRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addOrder(String tableNumber, OrdersEntityModel order) async {
    await firestore
        .collection('tables')
        .doc(tableNumber)
        .collection('orders')
        .doc(order.id)
        .set(order.toJson());
  }
}