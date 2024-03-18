import 'package:flutter/material.dart';
import 'package:canteen_app/Services/api_models/manager_model.dart';
import 'package:canteen_app/Services/api_models/general_model.dart';
import 'package:canteen_app/Services/api/canteen_service_manager.dart';

class OrderDetailManagerPage extends StatefulWidget {
  final String orderId;

  const OrderDetailManagerPage({required this.orderId, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderDetailManagerPageState createState() => _OrderDetailManagerPageState();
}

class _OrderDetailManagerPageState extends State<OrderDetailManagerPage> {
  late Future<OrderDetailManager> _orderDetailFuture;

  @override
  void initState() {
    super.initState();
    _orderDetailFuture = getOrderDetail(widget.orderId);

  }

  Future<OrderDetailManager> getOrderDetail(String orderId) async {
    return CanteenServiceManager().getOrderDetailManager(orderId);
  }



  Future<void> changeOrderStatus(String orderId, String status) async {
    try {
      await CanteenServiceManager().changeOrderStatus(orderId, status);
      setState(() {
        _orderDetailFuture = getOrderDetail(orderId);
      });
    } catch (e) {
      debugPrint('Error changing order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - ${widget.orderId}'),
      ),
      body: FutureBuilder(
        future: Future.wait([_orderDetailFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orderDetail = snapshot.data![0] as OrderDetailManager;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(height: 16),
                  const Text('Change Order Status:'),
                  Wrap(
                          spacing: 8.0,
                          children: [
                             if (orderDetail.status == 'Order Placed')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => changeOrderStatus(widget.orderId, 'APPROVED'),
                                        child: const Text('Accept'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => changeOrderStatus(widget.orderId, 'REJECTED'),
                                        child: const Text('Reject'),
                                      ),
                                    ],
                                  ),
                            if (orderDetail.status == 'Order Approved')
                              ElevatedButton(
                                onPressed: () => changeOrderStatus(widget.orderId, 'READY'),
                                child: const Text('Order Ready'),
                              ),
                          ],
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
