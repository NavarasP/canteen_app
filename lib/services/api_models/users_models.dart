class CanteenItemStudent {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String category;
  final String imageUrl;
  final bool isTodaysSpecial;

  CanteenItemStudent({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
    required this.imageUrl,
    required this.isTodaysSpecial,
  });

  factory CanteenItemStudent.fromJson(Map<String, dynamic> json) {
    return CanteenItemStudent(
      id: json['id'] as int? ?? 0, // Default value: 0
      name: json['name'] as String? ?? '', // Default value: ''
      price: json['price'] as double? ?? 0, // Default value: 0
      quantity: json['quantity'] as int? ?? 0, // Default value: 0
      category: json['category'] as String? ?? '', // Default value: ''
      imageUrl: json['image_url'] as String? ?? 'https://res.cloudinary.com/do6mh6z0s/image/upload/v1707292467/canteen_management/t5jrdentco4iztmlf67t.jpg', // Default value: ''
      isTodaysSpecial: json['is_todays_special'] as bool? ?? false, // Default value: false
    );
  }
}


class CartItem {
  final int itemId;
  final String itemName;
  final double itemPrice;
  int quantity;

  CartItem({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        itemId: json['itemId'],
        itemName: json['itemName'],
        itemPrice: json['itemPrice'],
        quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'quantity': quantity,
    };
  }
}

class Order {
  final int id;
  final String orderId;
  final double totalPrice;
  final String status;

  Order({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['order_id'],
      totalPrice: json['total_price'].toDouble(),
      status: json['status'],
    );
  }
}

class OrderDetail {
  final String orderId;
  final double totalPrice;
  final int totalQuantity;
  final String deliveryTime;
  final String status;
  final List<OrderItem> items;

  OrderDetail({
    required this.orderId,
    required this.totalPrice,
    required this.totalQuantity,
    required this.deliveryTime,
    required this.status,
    required this.items,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderId: json['order_id'],
      totalPrice: json['total_price'].toDouble(),
      totalQuantity: json['total_quantity'],
      deliveryTime: json['delivery_time'],
      status: json['status'],
      items: List<OrderItem>.from(
          json['items'].map((item) => OrderItem.fromJson(item))),
    );
  }
}


class OrderItem {
  final int id;
  final String foodId;
  final String foodName;
  final int quantity;
  final double price;
  final String? imageUrl;

  OrderItem({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      foodId: json['food_id'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
    );
  }
}
