import 'package:flutter/material.dart';
import 'package:canteen_app/services/Models/inspector_models.dart';
import 'package:canteen_app/services/api/canteen_service__inspector.dart';

class InspectorItemScreen extends StatefulWidget {
  const InspectorItemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InspectorItemScreenState createState() => _InspectorItemScreenState();
}

class _InspectorItemScreenState extends State<InspectorItemScreen> {
  List<CanteenItemInspector> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItemInspector> loadedItems =
          await CanteenServiceInspector().getFoodListInspector();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      debugPrint('Error loading items: $e');
    }
  }

  Future<void> _updateFoodStatus(int foodId, bool isApproved) async {
    try {
      await CanteenServiceInspector()
          .approveFood(foodId);
      _loadItems();
    } catch (e) {
      debugPrint('Error updating food status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspector Item List'),
      ),
      body: _buildItemList(),
    );
  }

  Widget _buildItemList() {
    items.sort((a, b) => (a.isApproved ? 1 : 0) - (b.isApproved ? 1 : 0));

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        CanteenItemInspector item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${item.price}'),
              Text('Quantity available: ${item.quantity}'),
              Text('Approved: ${item.isApproved ? 'Yes' : 'No'}'),
            ],
          ),
          onTap: () {
            _showApprovalPopup(context, item);
          },
        );
      },
    );
  }

  void _showApprovalPopup(BuildContext context, CanteenItemInspector item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Approve/Decline Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item: ${item.name}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _updateFoodStatus(item.id, true);
                  Navigator.of(context).pop();
                },
                child: const Text('Approve'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _updateFoodStatus(item.id, false);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Decline'),
              ),
            ],
          ),
        );
      },
    );
  }
}
