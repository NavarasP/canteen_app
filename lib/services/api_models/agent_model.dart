class OrderItemAgent {
  final int id;
  final String orderId;
  final double totalPrice;
  final String status;
  final String studentName;
  final String studentDepartment;
  final String studentMobile;

  OrderItemAgent({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.status,
    required this.studentName,
    required this.studentDepartment,
    required this.studentMobile,
  });

  factory OrderItemAgent.fromJson(Map<String, dynamic> json) {
    return OrderItemAgent(
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
