import 'package:rms/features/order/data/datasources/table_order_remote_data_source.dart';
import 'package:rms/features/order/domain/entities/table_order.dart';
import 'package:rms/features/order/domain/repositories/table_order_entity.dart';

import '../models/table_order_model.dart';

class TableOrderRepositoryImpl implements TableOrderRepository {
  final TableOrderRemoteDataSource remoteDataSource;

  TableOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addTable(TableOrder tableOrder) async {
    final model = TableOrderModel.fromEntity(tableOrder);
    await remoteDataSource.addTable(model);
  }

  @override
  Future<TableOrder> getTable(String tableNumber) async {
    final model = await remoteDataSource.getTable(tableNumber);
    return model.toEntity();
  }

  @override
  Future<void> addOrderToTable(String tableNumber, String orderId) async {
    await remoteDataSource.addOrderToTable(tableNumber, orderId);
  }

  @override
  Future<void> updateTableSeatedStatus(String tableNumber, bool seated) async {
    await remoteDataSource.updateTableSeatedStatus(tableNumber, seated);
  }
}