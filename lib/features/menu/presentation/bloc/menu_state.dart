part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItemEntity> items;
  const MenuLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class MenuError extends MenuState {
  final String message;
  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}

class MenuSyncing extends MenuState {
  final List<MenuItemEntity> items;
  const MenuSyncing(this.items);

  @override
  List<Object?> get props => [items];
}
