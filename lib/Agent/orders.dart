import 'package:flutter/material.dart';
import 'package:canteen_app/Models/users_models.dart';
import 'package:canteen_app/services/api/canteen_service__user.dart';


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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Details'),
          content: FutureBuilder<OrderDetail>(
            future: getOrderDetail(order.orderId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final orderDetail = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Order ID: ${orderDetail.orderId}'),
                    Text('Total Price: ${orderDetail.totalPrice}'),
                    Text('Total Quantity: ${orderDetail.totalQuantity}'),
                    Text('Delivery Time: ${orderDetail.deliveryTime}'),
                    Text('Status: ${orderDetail.status}'),
                    const Divider(),
                    const Text('Items:'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDetail.items.length,
                      itemBuilder: (context, index) {
                        final item = orderDetail.items[index];
                        return ListTile(
                          title: Text(item.foodName),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Text('Price: ${item.price}'),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<OrderDetail> getOrderDetail(String orderId) async {
    // Call the API to get the details of a specific order
    return CanteenServiceUser().getOrderDetailForStudent(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
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
