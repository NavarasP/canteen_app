

class CanteenItemManager {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final String approvedBy;
  final bool isTodaysSpecial;

  CanteenItemManager({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.isTodaysSpecial,
    required this.approvedBy,
  });

  factory CanteenItemManager.fromJson(Map<String, dynamic> json) {
    return CanteenItemManager(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      isTodaysSpecial: json['is_todays_special'],
      approvedBy: json['approved_by'] ?? '',
    );
  }
}



class FoodDetailManager {
  final int id;
  final String name;
  final String price;
  final int quantity;
  final bool isApproved;
  final bool isTodaysSpecial;
  final int categoryId;
  final int approvedById;
  final String imageUrl;
  final String categoryName;
  final String approvedByName;

  FoodDetailManager({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.isTodaysSpecial,
    required this.categoryId,
    required this.approvedById,
    required this.imageUrl,
    required this.categoryName,
    required this.approvedByName,
  });

  factory FoodDetailManager.fromJson(Map<String, dynamic> json) {
    return FoodDetailManager(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      isTodaysSpecial: json['is_todays_special'],
      categoryId: json['category_id'],
      approvedById: json['approved_by_id'],
      imageUrl: json['image_url'],
      categoryName: json['category_name'],
      approvedByName: json['approved_by_name'],
    );
  }
}





// class OrderStatusChangeResponse {
//   final bool result;
//   final String msg;
//   final dynamic data;

//   OrderStatusChangeResponse({
//     required this.result,
//     required this.msg,
//     required this.data,
//   });

//   factory OrderStatusChangeResponse.fromJson(Map<String, dynamic> json) {
//     return OrderStatusChangeResponse(
//       result: json['result'],
//       msg: json['msg'],
//       data: json['data'],
//     );
//   }
// }

class OrderListManager {
  final int id;
  final String orderId;
  final double totalPrice;
  final String status;
  final String student;

  OrderListManager({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.status,
    required this.student,
  });

  factory OrderListManager.fromJson(Map<String, dynamic> json) {
    return OrderListManager(
      id: json['id'],
      orderId: json['order_id'],
      totalPrice: json['total_price'].toDouble(),
      status: json['status'],
      student: json['student'],
    );
  }
}

class OrderDetailManager {
  final String orderId;
  final double totalPrice;
  final int totalQuantity;
  final String deliveryTime;
  final String status;
  final String remarks;
  final String student;
  final List<OrderItem> items;

  OrderDetailManager({
    required this.orderId,
    required this.totalPrice,
    required this.totalQuantity,
    required this.deliveryTime,
    required this.status,
    required this.remarks,
    required this.student,
    required this.items,
  });

  factory OrderDetailManager.fromJson(Map<String, dynamic> json) {
    return OrderDetailManager(
      orderId: json['order_id'],
      totalPrice: json['total_price'].toDouble(),
      totalQuantity: json['total_quantity'],
      deliveryTime: json['delivery_time'],
      status: json['status'],
      remarks: json['remarks'],
      student: json['student'],
      items: List<OrderItem>.from(json['items'].map((item) => OrderItem.fromJson(item))),
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
