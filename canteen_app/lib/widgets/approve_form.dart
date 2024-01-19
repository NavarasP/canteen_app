import 'package:flutter/material.dart';
import 'package:canteen_app/services/inspection_service.dart'; // Import your inspection service

class ApproveForm extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: commentController,
          decoration: InputDecoration(labelText: 'Comment (Optional)'),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add logic to approve the item
                String comment = commentController.text;
                InspectionService().approveItem(comment);
              },
              child: Text('Approve'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to reject the item
                String comment = commentController.text;
                InspectionService().rejectItem(comment);
              },
              child: Text('Reject'),
            ),
          ],
        ),
      ],
    );
  }
}
