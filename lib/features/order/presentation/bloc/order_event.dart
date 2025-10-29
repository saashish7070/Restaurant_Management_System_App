part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenuItems extends OrderEvent {
  final String tableNumber;

  const LoadMenuItems(this.tableNumber);

  @override
  List<Object?> get props => [tableNumber];
}

class AddItemToCart extends OrderEvent {
  final OrderItem item;

  const AddItemToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItemFromCart extends OrderEvent {
  final String menuItemId;

  const RemoveItemFromCart(this.menuItemId);

  @override
  List<Object?> get props => [menuItemId];
}

class UpdateTableSeatedStatus extends OrderEvent {
  final bool isSeated;

  const UpdateTableSeatedStatus(this.isSeated);

  @override
  List<Object?> get props => [isSeated];
}

class PlaceOrder extends OrderEvent {
  const PlaceOrder();
}