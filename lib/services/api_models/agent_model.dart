class OrderItem {
  final int id;
  final String orderId;
  final int totalPrice;
  final String status;
  final String studentName;
  final String studentDepartment;
  final String studentMobile;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.status,
    required this.studentName,
    required this.studentDepartment,
    required this.studentMobile,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      totalPrice: json['total_price'],
      status: json['status'],
      studentName: json['student_name'],
      studentDepartment: json['student_department'],
      studentMobile: json['student_mobile'],
    );
  }
}
