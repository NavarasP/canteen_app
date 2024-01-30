class User {
  final String uid;
  final String email;
  final String displayName;

  User({required this.uid, required this.email, required this.displayName});
}

class CanteenItem {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final String approvedBy;
  final bool isTodaysSpecial;
  final bool isVeg; 

  CanteenItem({
    required this.id,required this.name,required this.price,required this.quantity,required this.isApproved,
    required this.approvedBy,required this.isTodaysSpecial,required this.isVeg,});
}

class CartItem {
  final String itemName;
  final double itemPrice;
  final int quantity;

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
  final User user;
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




