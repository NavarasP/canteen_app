import 'package:flutter/material.dart';
import 'package:canteen_app/Users/order_detail.dart';
import 'package:canteen_app/Services/Models/users_models.dart';
import 'package:canteen_app/Services/api/canteen_service_user.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Future<List<Order>> _orderListFuture;

  @override
  void initState() {
    super.initState();
    _orderListFuture = getOrderList();
  }

  Future<List<Order>> getOrderList() async {
    // Call the API to get the list of orders
    return await CanteenServiceUser().getOrderListForStudent();
  }


void _showOrderDetail(BuildContext context, Order order) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OrderDetailPage(orderId: order.orderId),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Order>>(
        future: _orderListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order ID: ${order.orderId}'),
                  subtitle: Text('Total Price: ${order.totalPrice}'),
                  onTap: () => _showOrderDetail(context, order),
                );
              },
            );
          }
        },
      ),
    );
  }
}
