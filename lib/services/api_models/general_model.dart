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



class OrderStatusDropdown {
  final String value;
  final String text;

  OrderStatusDropdown({
    required this.value,
    required this.text,
  });

  factory OrderStatusDropdown.fromJson(Map<String, dynamic> json) {
    return OrderStatusDropdown(
      value: json['value'],
      text: json['text'],
    );
  }
}



