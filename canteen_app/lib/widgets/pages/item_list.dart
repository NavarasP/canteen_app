import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Today\'s Special'),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:canteen_app/models.dart';
// import 'package:canteen_app/widgets/item_list.dart'; // Assuming you have an item list widget

// class ItemScreen extends StatelessWidget {
//   final User user; // Pass the user to the widget

//   ItemScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text('Today\'s Special'),
//           const SizedBox(height: 20),
//           _buildContent(),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     switch (user.type) {
//       case UserType.user:
//         // Show item list with add to cart for regular users
//         return ItemList(canteenItems: canteenItems);
//       case UserType.inspector:
//         // Show approval/decline buttons for inspectors
//         return _buildInspectorContent();
//       case UserType.canteenTeam:
//         // Show editable options for canteen team
//         return _buildCanteenTeamContent();
//       default:
//         // Show a default message or an empty container for unknown user types
//         return const Text('Unknown user type');
//     }
//   }

//   Widget _buildInspectorContent() {
//     // Implement the content for inspectors (approval/decline buttons)
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             // Implement approval logic
//             print('Item Approved');
//           },
//           child: Text('Approve'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Implement decline logic
//             print('Item Declined');
//           },
//           child: Text('Decline'),
//         ),
//       ],
//     );
//   }

//   Widget _buildCanteenTeamContent() {
//     // Implement the content for the canteen team (editable options)
//     return const Text('Editable Options for Canteen Team');
//   }
// }
