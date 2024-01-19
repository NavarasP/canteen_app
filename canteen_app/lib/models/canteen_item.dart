// models/canteen_item.dart

class CanteenItem {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final String approvedBy;
  final bool isTodaysSpecial;

  CanteenItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.approvedBy,
    required this.isTodaysSpecial,
  });
}
