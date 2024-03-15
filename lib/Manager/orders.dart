import 'package:flutter/material.dart';
import 'package:canteen_app/Manager/order_detail.dart';
import 'package:canteen_app/Services/api_models/manager_model.dart';
import 'package:canteen_app/Services/api/canteen_service_manager.dart';

class OrderPageManager extends StatefulWidget {
  const OrderPageManager({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderPageManagerState createState() => _OrderPageManagerState();
}

class _OrderPageManagerState extends State<OrderPageManager> {
  late Future<List<OrderListManager>> _orderListFuture;

  @override
  void initState() {
    super.initState();
    _orderListFuture = getOrderList();
  }

  Future<List<OrderListManager>> getOrderList() async {
    return await CanteenServiceManager().getOrderListManager();
  }

  void _showOrderDetail(BuildContext context, OrderListManager order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailManagerPage(orderId: order.orderId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<OrderListManager>>(
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
