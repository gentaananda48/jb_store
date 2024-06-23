import 'package:flutter/material.dart';
import 'package:jb_store/screen/Profile/profile_page.dart';
import 'package:jb_store/screen/home_screen.dart';
import 'package:jb_store/screen/order.dart';
import 'package:jb_store/transaction/history_screen.dart'; // Import HistoryOrderScreen

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});
  
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected index
    switch (index = _selectedIndex) {
      case 0:
        // Navigate to Home
        Navigator.pop(context);
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> HomeScreen())
        );
        break;
      case 1:
        // Navigate to Orders
        Navigator.pop(context);
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>OrderScreen())
        );
        break;
      case 2:
        // Navigate to History
        Navigator.pop(context);
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>HistoryScreen(
            orderedProducts: [], 
            transactionData: {},
          ))
        );
        break;
      case 3:
        // Navigate to Profile
        Navigator.pop(context);
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>ProfileScreen())
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
