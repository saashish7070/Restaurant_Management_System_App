import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms/features/order/data/datasources/order_item_remote_data_source.dart';
import 'package:rms/features/order/data/datasources/orders_entity_remote_data_source.dart';
import 'package:rms/features/order/data/datasources/table_order_remote_data_source.dart';
import 'package:rms/features/order/data/repositories/order_entity_repository_impl.dart';
import 'data/repositories/table_order_repository_impl.dart';
import 'data/repositories/order_item_repository_impl.dart';
import 'presentation/bloc/order_bloc.dart';
import '../menu/domain/repositories/menu_repository.dart';

class OrderInjection {
  static Future<OrderBloc> provideOrderBloc(MenuRepository menuRepository) async {
    final orderItemRemoteDataSource = OrderItemRemoteDataSourceImpl(FirebaseFirestore.instance);
    final ordersEntityRemoteDataSource = OrdersEntityRemoteDataSourceImpl(FirebaseFirestore.instance);
    final tableOrderRemoteDataSource = TableOrderRemoteDataSourceImpl(FirebaseFirestore.instance);

    final orderItemRepository = OrderItemRepositoryImpl(
      remoteDataSource: orderItemRemoteDataSource,
    );

    final ordersEntityRepository = OrdersEntityRepositoryImpl(
      remoteDataSource: ordersEntityRemoteDataSource,
    );

    final tableOrderRepository = TableOrderRepositoryImpl(
      remoteDataSource: tableOrderRemoteDataSource,
    );

    return OrderBloc(
      orderItemRepository: orderItemRepository,
      ordersEntityRepository: ordersEntityRepository,
      tableOrderRepository: tableOrderRepository,
      menuRepository: menuRepository,
    );
  }
}