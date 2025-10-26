class OrderItem {
  final String menuItemId;
  final String name;
  final int quantity;
  final double price;
  final String? note; // Optional note like "extra spicy"

  OrderItem({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.price,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'menuItemId': menuItemId,
        'name': name,
        'quantity': quantity,
        'price': price,
        'note': note,
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        menuItemId: json['menuItemId'],
        name: json['name'],
        quantity: json['quantity'],
        price: json['price'],
        note: json['note'],
      );
}


enum OrderStatus {
  empty,       // Table has no order yet
  waiting,     // Table occupied but order not placed
  preparing,   // Order is being prepared
  served       // Order delivered to table
}

class TableOrder {
  final String tableNumber;
  final List<OrderItem> items;
  final OrderStatus status; 
  final DateTime orderTime;

  TableOrder({
    required this.tableNumber,
    required this.items,
    this.status = OrderStatus.empty, 
    required this.orderTime,
  });

  Map<String, dynamic> toJson() => {
        'tableNumber': tableNumber,
        'items': items.map((item) => item.toJson()).toList(),
        'status': status.name, // Store enum as string
        'orderTime': orderTime.toIso8601String(),
      };

  factory TableOrder.fromJson(Map<String, dynamic> json) => TableOrder(
        tableNumber: json['tableNumber'],
        items: (json['items'] as List)
            .map((item) => OrderItem.fromJson(item))
            .toList(),
        status: OrderStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => OrderStatus.empty,
        ),
        orderTime: DateTime.parse(json['orderTime']),
      );
}
