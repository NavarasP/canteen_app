import 'package:flutter/material.dart';
import 'package:canteen_app/Services/api_models/agent_model.dart';
import 'package:canteen_app/Services/api/canteen_service_agent.dart';

class OrderListAgentPage extends StatefulWidget {
  const OrderListAgentPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderListAgentPageState createState() => _OrderListAgentPageState();
}

class _OrderListAgentPageState extends State<OrderListAgentPage> {
  late Future<List<OrderItemAgent>> _orderListFuture;

  @override
  void initState() {
    super.initState();
    _orderListFuture = getOrderList();
  }

  Future<List<OrderItemAgent>> getOrderList() async {
    // Call the API to get the list of orders
    return await DeliveryAgentService().getOrderListForDeliveryAgent();
  }

  Future<void> orderPickedUp(OrderItemAgent order) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Order Pickup'),
          content: const Text('Are you sure you want to mark this order as picked up?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      // User confirmed, proceed with marking the order as picked up
      await DeliveryAgentService().updateOrderStatusPicked(order.orderId);
      setState(() {
        _orderListFuture = getOrderList();
      });
    }
  }

  Future<void> orderDelivered(OrderItemAgent order) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Order Delivery'),
          content: const Text('Are you sure you want to mark this order as delivered?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      // User confirmed, proceed with marking the order as delivered
      await DeliveryAgentService().updateOrderStatusDelivered(order.orderId);
      setState(() {
        _orderListFuture = getOrderList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder<List<OrderItemAgent>>(
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
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Order ID: ${order.orderId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Price: ${order.totalPrice}'),
                        Text('Status: ${order.status}'),
                      ],
                    ),
                    trailing: order.status == 'Order Ready To be Delivered'
                        ? ElevatedButton(
                            onPressed: () => orderPickedUp(order),
                            child: const Text('Pick Up'),
                          )
                        : order.status == 'Order Picked By Delivery Agent'
                            ? ElevatedButton(
                                onPressed: () => orderDelivered(order),
                                child: const Text('Delivered'),
                              )
                            : null,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
