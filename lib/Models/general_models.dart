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

class Course {
  final String value;
  final String text;

  Course({required this.value, required this.text});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      value: json['value'] ?? '',
      text: json['text'] ?? '',
    );
  }

  static List<Course> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}



// class Order {
//   final String orderId;
//   final String user;
//   final List<CanteenItem> items;
//   final DateTime orderDate;
//   final double totalAmount;

//   Order({
//     required this.orderId,
//     required this.user,
//     required this.items,
//     required this.orderDate,
//     required this.totalAmount,
//   });
// }


