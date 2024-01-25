// import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> approveItem( String comment) async {
    // Implement logic to update item status to approved in your database
    try {
      // await _firestore.collection('canteen_items').doc(itemId).update({
      //   'status': 'approved',
      //   'comment': comment,
      // });
      print('Item Approved Successfully');
    } catch (e) {
      print('Error approving item: $e');
    }
  }

  Future<void> rejectItem( String comment) async {
    // Implement logic to update item status to rejected in your database
    try {
      // await _firestore.collection('canteen_items').doc(itemId).update({
      //   'status': 'rejected',
      //   'comment': comment,
      // });
      print('Item Rejected Successfully');
    } catch (e) {
      print('Error rejecting item: $e');
    }
  }
}
