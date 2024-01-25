import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/approve_form.dart'; // Import the ApproveForm

class InspectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for new items (replace it with your actual data)

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspector Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Inspector Screen'),
            SizedBox(height: 20),
            // Display the list of new items with ApprovalCard
            // for (var item in newItems)
            //   ApprovalForm(item: item), // Assuming you have an ApprovalCard widget

            // Display the ApproveForm for approving or rejecting items
            ApproveForm(),
          ],
        ),
      ),
    );
  }
}
