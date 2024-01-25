// screens/canteen_team_screen.dart

import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/forms/add_item_form.dart'; // Import other widget files

class CanteenTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen Team Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Canteen Team Screen'),
            SizedBox(height: 20),
            AddItemForm(), 
          ],
        ),
      ),
    );
  }
}
