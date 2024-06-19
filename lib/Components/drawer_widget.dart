import 'package:flutter/material.dart';
import 'package:jb_store/Services/profile_service.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Future<Map<String, dynamic>> _userData;
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _userData = _profileService.getUser(2);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            var user = snapshot.data!;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                      '${user['name']['firstname']} ${user['name']['lastname']}'),
                  accountEmail: Text(user['phone']),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://via.placeholder.com/150"),
                  ),
                  arrowColor: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.grid_view),
                  title: Text('Shop by Categories'),
                  onTap: () {
                    // Navigate to categories page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('My Orders'),
                  onTap: () {
                    // Navigate to orders page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text('Favourites'),
                  onTap: () {
                    // Navigate to favourites page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text('FAQs'),
                  onTap: () {
                    // Navigate to FAQs page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Addresses'),
                  onTap: () {
                    // Navigate to addresses page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Saved Cards'),
                  onTap: () {
                    // Navigate to saved cards page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Terms & Conditions'),
                  onTap: () {
                    // Navigate to terms & conditions page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Privacy Policy'),
                  onTap: () {
                    // Navigate to privacy policy page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
