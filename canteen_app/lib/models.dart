

class CanteenItem {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final String approvedBy;
  final bool isTodaysSpecial;
  // final bool isVeg;

  CanteenItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.approvedBy,
    required this.isTodaysSpecial,
    // required this.isVeg,
  });

  factory CanteenItem.fromJson(Map<String, dynamic> json) {
    return CanteenItem(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      approvedBy: json['approved_by'] ?? '',
      isTodaysSpecial: json['is_todays_special'],
      // isVeg: json['is_veg'],
    );
  }
}

class FoodItemDetails {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final bool isTodaysSpecial;
  final int categoryId;
  final int approvedById;
  final String categoryName;
  final String approvedByName;

  FoodItemDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.isTodaysSpecial,
    required this.categoryId,
    required this.approvedById,
    required this.categoryName,
    required this.approvedByName,
  });

  factory FoodItemDetails.fromJson(Map<String, dynamic> json) {
    return FoodItemDetails(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      isTodaysSpecial: json['is_todays_special'],
      categoryId: json['category_id'],
      approvedById: json['approved_by_id'],
      categoryName: json['category_name'],
      approvedByName: json['approved_by_name'] ?? '',
    );
  }
}

class FoodCategory {
  final int id;
  final String name;

  FoodCategory({
    required this.id,
    required this.name,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}




class CartItem {
  final String itemName;
  final double itemPrice;
   int quantity;

  CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
  });

    factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemName: json['itemName'] ?? '',
      itemPrice: json['itemPrice'] ?? 0.0,
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemPrice': itemPrice,
      'quantity': quantity,
    };
  }


}


class Order {
  final String orderId;
  final String user;
  final List<CanteenItem> items;
  final DateTime orderDate;
  final double totalAmount;

  Order({
    required this.orderId,
    required this.user,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
  });
}




