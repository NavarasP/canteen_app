class CanteenItemStudent {
  final int id;
  final String name;
  final int price;
  final int quantity;
  final bool isTodaysSpecial;
  // final bool isVeg;

  CanteenItemStudent({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isTodaysSpecial,
    // required this.isVeg,
  });

  factory CanteenItemStudent.fromJson(Map<String, dynamic> json) {
    return CanteenItemStudent(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      isTodaysSpecial: json['is_todays_special'],
      // isVeg: json['is_veg'],
    );
  }
}

class CartItem {
  final String itemName;
  final int itemPrice;
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





// class FoodItemDetails {
//   final int id;
//   final String name;
//   final double price;
//   final int quantity;
//   final bool isApproved;
//   final bool isTodaysSpecial;
//   final int categoryId;
//   final int approvedById;
//   final String categoryName;
//   final String approvedByName;

//   FoodItemDetails({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.isApproved,
//     required this.isTodaysSpecial,
//     required this.categoryId,
//     required this.approvedById,
//     required this.categoryName,
//     required this.approvedByName,
//   });

//   factory FoodItemDetails.fromJson(Map<String, dynamic> json) {
//     return FoodItemDetails(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       quantity: json['quantity'],
//       isApproved: json['is_approved'],
//       isTodaysSpecial: json['is_todays_special'],
//       categoryId: json['category_id'],
//       approvedById: json['approved_by_id'],
//       categoryName: json['category_name'],
//       approvedByName: json['approved_by_name'] ?? '',
//     );
//   }
// }






