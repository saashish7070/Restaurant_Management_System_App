class MenuItemEntity {
  final String id;
  final String name;
  final String price;
  final bool available;
  final List<String> cuisine;
  final List<String> categories;
  final bool typeItem;
  final String imageUrl;
  final String ingredient;

  MenuItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.cuisine,
    required this.categories,
    required this.typeItem,
    required this.imageUrl,
    required this.ingredient,
  });
}
