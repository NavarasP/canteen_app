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
      price: double.parse(json['price']),
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      isTodaysSpecial: json['is_todays_special'],
      approvedBy: json['approved_by'] ?? '',
    );
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
