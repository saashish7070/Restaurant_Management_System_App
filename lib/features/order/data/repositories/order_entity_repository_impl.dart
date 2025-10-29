import 'package:rms/features/order/data/datasources/orders_entity_remote_data_source.dart';
import 'package:rms/features/order/domain/entities/orders_entity.dart';

import '../../domain/repositories/orders_entity_repository.dart';
import '../models/orders_entity_model.dart';

class OrdersEntityRepositoryImpl implements OrdersEntityRepository {
  final OrdersEntityRemoteDataSource remoteDataSource;

  OrdersEntityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addOrder(String tableNumber, OrdersEntity order) async {
    final model = OrdersEntityModel.fromEntity(order);
    await remoteDataSource.addOrder(tableNumber, model);
  }
}