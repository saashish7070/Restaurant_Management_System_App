import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rms/features/menu/domain/repositories/menu_repository.dart';
import 'package:rms/features/menu/domain/entities/menu_item.dart';
import 'package:rms/features/order/domain/entities/order_entity';
import 'package:rms/features/order/domain/entities/orders_entity.dart';
import 'package:rms/features/order/domain/entities/table_order.dart';
import 'package:rms/features/order/domain/repositories/order_item_repository.dart';
import 'package:rms/features/order/domain/repositories/orders_entity_repository.dart';
import 'package:rms/features/order/domain/repositories/table_order_entity.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderItemRepository orderItemRepository;
  final OrdersEntityRepository ordersEntityRepository;
  final TableOrderRepository tableOrderRepository;
  final MenuRepository menuRepository;

  OrderBloc({
    required this.orderItemRepository,
    required this.ordersEntityRepository,
    required this.tableOrderRepository,
    required this.menuRepository,
  }) : super(OrderInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateTableSeatedStatus>(_onUpdateTableSeatedStatus);
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final menuItems = await menuRepository.getMenuItems();
      print(menuItems);
      emit(OrderLoaded(
        menuItems: menuItems,
        cartItems: {},
        tableNumber: event.tableNumber,
        isSeated: false,
      ));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void _onAddItemToCart(
    AddItemToCart event,
    Emitter<OrderState> emit,
  ) {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      final updatedCart = Map<String, OrderItem>.from(currentState.cartItems);

      if (updatedCart.containsKey(event.item.menuItemId)) {
        final existingItem = updatedCart[event.item.menuItemId]!;
        updatedCart[event.item.menuItemId] = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
      } else {
        updatedCart[event.item.menuItemId] = event.item.copyWith(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          quantity: 1,
        );
      }

      emit(currentState.copyWith(cartItems: updatedCart));
    }
  }

  void _onRemoveItemFromCart(
    RemoveItemFromCart event,
    Emitter<OrderState> emit,
  ) {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      final updatedCart = Map<String, OrderItem>.from(currentState.cartItems);

      if (updatedCart.containsKey(event.menuItemId)) {
        final existingItem = updatedCart[event.menuItemId]!;
        if (existingItem.quantity > 1) {
          updatedCart[event.menuItemId] = existingItem.copyWith(
            quantity: existingItem.quantity - 1,
          );
        } else {
          updatedCart.remove(event.menuItemId);
        }
      }

      emit(currentState.copyWith(cartItems: updatedCart));
    }
  }

  void _onUpdateTableSeatedStatus(
    UpdateTableSeatedStatus event,
    Emitter<OrderState> emit,
  ) {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      emit(currentState.copyWith(isSeated: event.isSeated));
    }
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<OrderState> emit,
  ) async {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      
      if (currentState.cartItems.isEmpty) {
        emit(const OrderError('Cart is empty'));
        emit(currentState);
        return;
      }

      emit(OrderPlacing());

      try {
        final orderId = DateTime.now().millisecondsSinceEpoch.toString();
        
        final order = OrdersEntity(
          id: orderId,
          orderIds: currentState.cartItems.keys.toList(),
          orderStatus: OrderStatus.waiting,
        );

        await ordersEntityRepository.addOrder(currentState.tableNumber, order);

        for (final item in currentState.cartItems.values) {
          final orderItem = item.copyWith(
            id: '${orderId}_${item.menuItemId}',
          );
          await orderItemRepository.addOrderItem(
            currentState.tableNumber,
            orderId,
            orderItem,
          );
        }

        try {
          await tableOrderRepository.getTable(currentState.tableNumber);
          await tableOrderRepository.addOrderToTable(currentState.tableNumber, orderId);
        } catch (e) {
          final newTable = TableOrder(
            tableNumber: currentState.tableNumber,
            orderIds: [orderId],
            seated: currentState.isSeated,
          );
          await tableOrderRepository.addTable(newTable);
        }
        
        if (currentState.isSeated) {
          await tableOrderRepository.updateTableSeatedStatus(
            currentState.tableNumber,
            true,
          );
        }

        emit(OrderPlaced());
        
        emit(OrderLoaded(
          menuItems: currentState.menuItems,
          cartItems: {},
          tableNumber: currentState.tableNumber,
          isSeated: currentState.isSeated,
        ));
      } catch (e) {
        emit(OrderError(e.toString()));
        emit(currentState);
      }
    }
  }
}
