
class CanteenItem_Inspector {
  final int id;
  final String name;
  final String price;
  final int quantity;
  final String? imageUrl;
  final bool isApproved;

  CanteenItem_Inspector({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    required this.isApproved,
  });

  factory CanteenItem_Inspector.fromJson(Map<String, dynamic> json) {
    return CanteenItem_Inspector(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['image_url'],
      isApproved: json['is_approved'],
    );
  }
}

class CanteenItemDetail_Inspector {
  final int id;
  final String name;
  final String price;
  final int quantity;
  final bool isApproved;
  final int categoryId;
  final String categoryName;
  final String? imageUrl;

  CanteenItemDetail_Inspector({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.categoryId,
    required this.categoryName,
    this.imageUrl,
  });

  factory CanteenItemDetail_Inspector.fromJson(Map<String, dynamic> json) {
    return CanteenItemDetail_Inspector(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      isApproved: json['is_approved'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      imageUrl: json['image_url'],
    );
  }
}
