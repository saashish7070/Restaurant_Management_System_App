part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<MenuItemEntity> menuItems;
  final Map<String, OrderItem> cartItems;
  final String tableNumber;
  final bool isSeated;

  const OrderLoaded({
    required this.menuItems,
    required this.cartItems,
    required this.tableNumber,
    required this.isSeated,
  });

  OrderLoaded copyWith({
    List<MenuItemEntity>? menuItems,
    Map<String, OrderItem>? cartItems,
    String? tableNumber,
    bool? isSeated,
  }) {
    return OrderLoaded(
      menuItems: menuItems ?? this.menuItems,
      cartItems: cartItems ?? this.cartItems,
      tableNumber: tableNumber ?? this.tableNumber,
      isSeated: isSeated ?? this.isSeated,
    );
  }

  @override
  List<Object?> get props => [menuItems, cartItems, tableNumber, isSeated];
}

class OrderPlacing extends OrderState {}

class OrderPlaced extends OrderState {}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}
