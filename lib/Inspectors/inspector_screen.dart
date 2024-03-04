import 'package:flutter/material.dart';
import 'package:canteen_app/services/widgets/profile.dart';
import 'package:canteen_app/services/color_schemes.g.dart';
import 'package:canteen_app/Inspectors/itemlist_inspector.dart';

class InspectorScreen extends StatefulWidget {
  const InspectorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InspectorScreenState createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
  int _currentIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), 
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
        return AppBar(title: const Text('Home'));
      case 1:
        return AppBar(title: const Text('Profile'));
      default:
        return AppBar(); 
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const InspectorItemScreen();
      case 1:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
