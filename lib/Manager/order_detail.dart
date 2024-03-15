import 'package:flutter/material.dart';
import 'package:canteen_app/Services/api/genaral_api_service.dart';
import 'package:canteen_app/Services/api_models/manager_model.dart';
import 'package:canteen_app/Services/api_models/general_model.dart';
import 'package:canteen_app/Services/api/canteen_service_manager.dart';

class OrderDetailManagerPage extends StatefulWidget {
  final String orderId;

  const OrderDetailManagerPage({required this.orderId, Key? key}) : super(key: key);

  @override
  _OrderDetailManagerPageState createState() => _OrderDetailManagerPageState();
}

class _OrderDetailManagerPageState extends State<OrderDetailManagerPage> {
  late Future<OrderDetailManager> _orderDetailFuture;
  late Future<List<OrderStatusDropdown>> _orderStatusDropdownFuture;

  @override
  void initState() {
    super.initState();
    _orderDetailFuture = getOrderDetail(widget.orderId);
    _orderStatusDropdownFuture = getOrderStatusDropdown();
  }

  Future<OrderDetailManager> getOrderDetail(String orderId) async {
    return CanteenServiceManager().getOrderDetailManager(orderId);
  }

  Future<List<OrderStatusDropdown>> getOrderStatusDropdown() async {
    return GenralService().getOrderStatusDropdown();
  }

  Future<void> changeOrderStatus(String orderId, String status) async {
    try {
      await CanteenServiceManager().changeOrderStatus(orderId, status);
      setState(() {
        _orderDetailFuture = getOrderDetail(orderId);
      });
    } catch (e) {
      print('Error changing order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - ${widget.orderId}'),
      ),
      body: FutureBuilder(
        future: Future.wait([_orderDetailFuture, _orderStatusDropdownFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orderDetail = snapshot.data![0] as OrderDetailManager;
            final orderStatusDropdown = snapshot.data![1] as List<OrderStatusDropdown>;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
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
                                        child: Text('Accept'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => changeOrderStatus(widget.orderId, 'REJECTED'),
                                        child: Text('Reject'),
                                      ),
                                    ],
                                  ),
                            if (orderDetail.status == 'Order Approved')
                              ElevatedButton(
                                onPressed: () => changeOrderStatus(widget.orderId, 'READY'),
                                child: Text('Order Ready'),
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
