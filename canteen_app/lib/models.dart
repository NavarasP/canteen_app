class User {
  final String uid;
  final String email;
  final String displayName;

  User({required this.uid, required this.email, required this.displayName});
}

class CanteenItem {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isApproved;
  final String approvedBy;
  final bool isTodaysSpecial;
  final bool isVeg; 

  CanteenItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isApproved,
    required this.approvedBy,
    required this.isTodaysSpecial,
    required this.isVeg, 
  });
}

class CartItem {
  final String itemName;
  final double itemPrice;
  int itemCount;

  CartItem({
    required this.itemName,
    required this.itemPrice,
    this.itemCount = 1,
  });
}

class Order {
  final String orderId;
  final User user;
  final List<CanteenItem> items;
  final DateTime orderDate;
  final double totalAmount;

  Order({
    required this.orderId,
    required this.user,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
  });
}



final User currentUser = User(
  uid: 'user123',
  email: 'user@example.com',
  displayName: 'John Doe',
);
final List<CanteenItem> canteenItems = [
  CanteenItem(id: 1,name: 'Burger',price: 5.99,quantity: 10,isApproved: true,approvedBy: 'Admin1',isTodaysSpecial: true,isVeg: false,),
  CanteenItem(id: 2,name: 'Pizza',price: 8.99,quantity: 5,isApproved: true,approvedBy: 'Admin2',isTodaysSpecial: false,isVeg: true,),
  CanteenItem(id: 3,name: 'Pazhampori',price: 8.99,quantity: 5,isApproved: true,approvedBy: 'Admin2',isTodaysSpecial: false,isVeg: true,),
  CanteenItem(id: 4,name: 'Puffs',price: 4.99,quantity: 8,isApproved: false,approvedBy: '',isTodaysSpecial: true,isVeg: true, ),
  CanteenItem(id: 5,name: 'Parippuvada',price: 4.99,quantity: 8,isApproved: false,approvedBy: '',isTodaysSpecial: true,isVeg: true, ),
  CanteenItem(id: 6,name: 'Ullivada',price: 4.99,quantity: 8,isApproved: false,approvedBy: '',isTodaysSpecial: true,isVeg: true, ),
  CanteenItem(id: 7,name: 'Unnakkaya',price: 4.99,quantity: 8,isApproved: false,approvedBy: '',isTodaysSpecial: true,isVeg: true, ),
  CanteenItem(id: 8,name: 'Salad',price: 4.99,quantity: 8,isApproved: false,approvedBy: '',isTodaysSpecial: true,isVeg: true, ),


];

final Order order1 = Order(
  orderId: 'order123',
  user: currentUser,
  items: [
    canteenItems[0], 
    canteenItems[2], 
  ],
  orderDate: DateTime.now(),
  totalAmount: 10.98, 
);

final Order order2 = Order(
  orderId: 'order456',
  user: currentUser,
  items: [
    canteenItems[1], 
    canteenItems[3], 
  ],
  orderDate: DateTime.now(),
  totalAmount: 13.98, 
);




  List<CartItem> cartItems = [
    CartItem(itemName: 'Item 1', itemPrice: 10.0),
    CartItem(itemName: 'Item 2', itemPrice: 15.0),
  ];