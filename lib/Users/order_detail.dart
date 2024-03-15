import 'package:flutter/material.dart';
import 'package:canteen_app/Services/api_models/users_models.dart';
import 'package:canteen_app/Services/api/canteen_service_user.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({required this.orderId, super.key});

  Future<OrderDetail> getOrderDetail(String orderId) async {
    return CanteenServiceUser().getOrderDetailForStudent(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - $orderId'),
      ),
      body: FutureBuilder<OrderDetail>(
        future: getOrderDetail(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orderDetail = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
