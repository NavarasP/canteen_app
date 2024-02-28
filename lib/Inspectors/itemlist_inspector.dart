import 'package:flutter/material.dart';
import 'package:canteen_app/Models/inspector_models.dart';
import 'package:canteen_app/services/api/canteen_service__inspector.dart';

class InspectorItemScreen extends StatefulWidget {
  @override
  _InspectorItemScreenState createState() => _InspectorItemScreenState();
}

class _InspectorItemScreenState extends State<InspectorItemScreen> {
  List<CanteenItem_Inspector> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItem_Inspector> loadedItems =
          await CanteenServiceInspector().getFoodListInspector();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      // Handle errors
      debugPrint('Error loading items: $e');
    }
  }

  Future<void> _updateFoodStatus(int foodId, bool isApproved) async {
    try {
      await CanteenServiceInspector()
          .approveFood(foodId);
      // Refresh the item list after updating the food status
      _loadItems();
    } catch (e) {
      // Handle errors
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
    // Sort items to show non-approved items on top
    items.sort((a, b) => (a.isApproved ? 1 : 0) - (b.isApproved ? 1 : 0));

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        CanteenItem_Inspector item = items[index];
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
            // Show pop-up to approve or decline the selected item
            _showApprovalPopup(context, item);
          },
        );
      },
    );
  }

  void _showApprovalPopup(BuildContext context, CanteenItem_Inspector item) {
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
                  // Approve the item
                  _updateFoodStatus(item.id, true);
                  Navigator.of(context).pop();
                },
                child: const Text('Approve'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Decline the item
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
