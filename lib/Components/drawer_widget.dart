import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Shop By Categories'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('My Orders'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourites'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('FAQs'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Addresses'),
            onTap: () {
              // Handle navigation
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // Handle log out
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}