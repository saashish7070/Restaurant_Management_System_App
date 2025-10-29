import 'package:rms/features/order/data/datasources/order_item_remote_data_source.dart';
import 'package:rms/features/order/domain/entities/order_entity';

import '../../domain/repositories/order_item_repository.dart';
import '../models/order_item_model.dart';

class OrderItemRepositoryImpl implements OrderItemRepository {
  final OrderItemRemoteDataSource remoteDataSource;

  OrderItemRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> addOrderItem(String tableNumber, String orderId, OrderItem item) async {
    final model = OrderItemModel.fromEntity(item);
    await remoteDataSource.addOrderItem(tableNumber, orderId, model);
  }
}