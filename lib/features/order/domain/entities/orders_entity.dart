enum OrderStatus {
  empty,
  waiting,
  preparing,
  served,
}

class OrdersEntity {
  final String id;
  final List<String>? orderIds;
  final OrderStatus orderStatus;
  final DateTime orderTime;
  
  OrdersEntity({
    required this.id,
    this.orderIds,
    this.orderStatus = OrderStatus.empty,
    DateTime? orderTime,
  }) : orderTime = orderTime ?? DateTime.now();
  
  Map<String, dynamic> toJson() => {
        'id': id,
        'orderIds': orderIds,
        'orderStatus': orderStatus.name,
        'orderTime': orderTime.millisecondsSinceEpoch,
      };
  
  factory OrdersEntity.fromJson(Map<String, dynamic> json) => OrdersEntity(
        id: json['id'],
        orderIds: json['orderIds'] != null 
            ? List<String>.from(json['orderIds']) 
            : null,
        orderStatus: json['orderStatus'] != null
            ? OrderStatus.values.firstWhere(
                (e) => e.name == json['orderStatus'],
                orElse: () => OrderStatus.empty,
              )
            : OrderStatus.empty,
        orderTime: json['orderTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['orderTime'])
            : DateTime.now(),
      );
}