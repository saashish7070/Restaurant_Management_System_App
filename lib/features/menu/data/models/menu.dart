// class MenuItem {
//   final String id;
//   String name;
//   String price;
//   bool available;
//   List<String> cuisine;
//   List<String> categories;
//   bool typeItem;
//   String imageUrl;
//   String ingredient;

//   MenuItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.available,
//     required this.cuisine,
//     required this.categories,
//     required this.typeItem,
//     required this.imageUrl,
//     required this.ingredient,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'price': price,
//         'available': available,
//         'cuisine': cuisine,
//         'categories': categories,
//         'typeItem': typeItem,
//         'imageUrl': imageUrl,
//         'ingredient': ingredient,
//       };

//   factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
//         id: json['id'],
//         name: json['name'],
//         price: json['price'],
//         available: json['available'],
//         cuisine: List<String>.from(json['cuisine']),
//         categories: List<String>.from(json['categories']),
//         typeItem: json['typeItem'],
//         imageUrl: json['imageUrl'],
//         ingredient: json['ingredient'],
//       );
// }


// class Menu {
//   final String restaurantId;
//   final List<MenuItem> items;

//   Menu({
//     required this.restaurantId,
//     required this.items,
//   });

//   Map<String, dynamic> toJson() => {
//         'restaurantId': restaurantId,
//         'items': items.map((item) => item.toJson()).toList(),
//       };

//   factory Menu.fromJson(Map<String, dynamic> json) => Menu(
//         restaurantId: json['restaurantId'],
//         items: (json['items'] as List)
//             .map((item) => MenuItem.fromJson(item))
//             .toList(),
//       );
// }
