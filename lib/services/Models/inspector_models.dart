
class CanteenItemInspector {
  final int id;
  final String name;
  final int price;
  final int quantity;
  final String? imageUrl;
  final bool isApproved;

  CanteenItemInspector({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    required this.isApproved,
  });

  factory CanteenItemInspector.fromJson(Map<String, dynamic> json) {
    return CanteenItemInspector(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['image_url'],
      isApproved: json['is_approved'],
    );
  }
}

class CanteenItemDetailInspector {
  final int id;
  final String name;
  final int price;
  final int quantity;
  final bool isApproved;
  final int categoryId;
  final String categoryName;
  final String? imageUrl;

  CanteenItemDetailInspector({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.categoryId,
    required this.categoryName,
    this.imageUrl,
  });

  factory CanteenItemDetailInspector.fromJson(Map<String, dynamic> json) {
    return CanteenItemDetailInspector(
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
