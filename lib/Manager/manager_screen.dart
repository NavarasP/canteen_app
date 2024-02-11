import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/profile.dart';
import 'package:canteen_app/Manager/itemlist_manager.dart';


class CanteenTeamScreen extends StatefulWidget {
  @override
  _CanteenTeamScreenState createState() => _CanteenTeamScreenState();
}

class _CanteenTeamScreenState extends State<CanteenTeamScreen> {
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
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
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
        return ItemScreen_Manager();
      case 1:
        return ProfilePage();
      default:
        return Container();
    }
  }
}
