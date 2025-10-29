import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/table_order_model.dart';

abstract class TableOrderRemoteDataSource {
  Future<void> addTable(TableOrderModel tableOrder);
  Future<TableOrderModel> getTable(String tableNumber);
  Future<void> addOrderToTable(String tableNumber, String orderId);
  Future<void> updateTableSeatedStatus(String tableNumber, bool seated);
}

class TableOrderRemoteDataSourceImpl implements TableOrderRemoteDataSource {
  final FirebaseFirestore firestore;
  TableOrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addTable(TableOrderModel tableOrder) async {
    await firestore.collection('tables').doc(tableOrder.tableNumber).set(tableOrder.toJson());
  }

  @override
  Future<TableOrderModel> getTable(String tableNumber) async {
    final doc = await firestore.collection('tables').doc(tableNumber).get();
    return TableOrderModel.fromJson(doc.data()!);
  }

  @override
  Future<void> addOrderToTable(String tableNumber, String orderId) async {
    await firestore.collection('tables').doc(tableNumber).update({
      'orderIds': FieldValue.arrayUnion([orderId])
    });
  }

  @override
  Future<void> updateTableSeatedStatus(String tableNumber, bool seated) async {
    await firestore.collection('tables').doc(tableNumber).update({'seated': seated});
  }
}