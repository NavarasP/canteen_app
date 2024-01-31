import 'package:flutter/material.dart';
import 'package:canteen_app/services/models.dart';
import 'package:canteen_app/services/api_service.dart';


class InspectorItemScreen extends StatefulWidget {
  @override
  _InspectorItemScreenState createState() => _InspectorItemScreenState();
}

class _InspectorItemScreenState extends State<InspectorItemScreen> {
  List<CanteenItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      List<CanteenItem> loadedItems = await CanteenService().getFoodList();
      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      // Handle errors
      print('Error loading items: $e');
    }
  }

  Future<void> _updateFoodStatus(int foodId, bool isApproved) async {
    try {
      await CanteenService().updateFood(foodId, {'is_approved': isApproved});
      // Refresh the item list after updating the food status
      _loadItems();
    } catch (e) {
      // Handle errors
      print('Error updating food status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspector Item List'),
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
        CanteenItem item = items[index];
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

  void _showApprovalPopup(BuildContext context, CanteenItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approve/Decline Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item: ${item.name}'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Approve the item
                  _updateFoodStatus(item.id, true);
                  Navigator.of(context).pop();
                },
                child: Text('Approve'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Decline the item
                  _updateFoodStatus(item.id, false);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Decline'),
              ),
            ],
          ),
        );
      },
    );
  }
}
