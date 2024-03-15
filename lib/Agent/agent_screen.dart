import 'package:flutter/material.dart';
import 'package:canteen_app/Agent/agent_orders.dart';
import 'package:canteen_app/Services/widgets/profile.dart';
import 'package:canteen_app/Services/color_schemes.g.dart';


class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  
  // ignore: library_private_types_in_public_api
  _AgentScreenState createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
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

 AppBar  _buildAppBar() {
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
        return const OrderListAgentPage();
      case 1:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
