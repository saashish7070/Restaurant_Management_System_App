import 'package:equatable/equatable.dart';
import '../../domain/entities/menu_item.dart';

abstract class MenuState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItemEntity> menuItems;
  MenuLoaded(this.menuItems);

  @override
  List<Object?> get props => [menuItems];
}

class MenuError extends MenuState {
  final String message;
  MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
