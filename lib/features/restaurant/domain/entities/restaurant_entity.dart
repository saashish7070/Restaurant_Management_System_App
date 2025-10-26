class RestaurantEntity {
  final String id;
  final String name;
  final String location;
  final String menuId;
  final String orderId;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.menuId,
    required this.orderId,
  });
}
