import 'package:flutter/material.dart';
import 'package:canteen_app/color_schemes.g.dart';
import 'package:canteen_app/widgets/pages/item_list.dart';
import 'package:canteen_app/models.dart';
import 'package:canteen_app/widgets/pages/profile.dart';

class InspectorScreen extends StatefulWidget {
  @override
  _InspectorScreenState createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
  int _currentIndex = 0; // Index for the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Use a method to build the app bar
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    switch (_currentIndex) {
      case 0:
        return AppBar(title: Text('Home'));
      case 1:
        return AppBar(title: Text('Profile'));
      default:
        return AppBar(); // Default app bar for other cases
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return ItemScreen();
      case 1:
        return ProfilePage(
          userName: currentUser.displayName,
          userDetails: 'Add your user details here', // Modify with actual user details
          onLogout: () {
            print('Logout button pressed');
          },
        );
      default:
        return Container();
    }
  }
}
