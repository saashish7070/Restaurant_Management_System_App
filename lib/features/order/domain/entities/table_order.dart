class TableOrder {
  final String tableNumber;
  final List<String> orderIds;
  final bool seated;

  TableOrder({
    required this.tableNumber,
    required this.orderIds,
    this.seated = false
  });

  Map<String, dynamic> toJson() => {
        'tableNumber': tableNumber,
        'orderIds': orderIds,
        'seated': seated,
      };

  factory TableOrder.fromJson(Map<String, dynamic> json) => TableOrder(
        tableNumber: json['tableNumber'],
        orderIds: json['orderIds'] != null
            ? List<String>.from(json['orderIds'])
            : [],
        seated: json['seated'] ?? false,
      );
}