import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userData;
  bool _isEditing = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _userData = _apiService.getUser(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? 'Save' : 'Edit Profile',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
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
            var nameController = TextEditingController(
                text:
                    '${user['name']['firstname']} ${user['name']['lastname']}');
            var emailController = TextEditingController(text: user['email']);
            var phoneController = TextEditingController(text: user['phone']);
            var locationController = TextEditingController(
                text:
                    '${user['address']['street']}, ${user['address']['city']}');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage("https://via.placeholder.com/150"),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    readOnly: !_isEditing,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    readOnly: !_isEditing,
                    decoration: InputDecoration(
                      labelText: 'Email Id',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    readOnly: !_isEditing,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: locationController,
                    readOnly: !_isEditing,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Gender:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      // Aksi untuk pilihan Male
                                    }
                                  : null,
                            ),
                            Text('Male'),
                            Radio(
                              value: 'Female',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      // Aksi untuk pilihan Female
                                    }
                                  : null,
                            ),
                            Text('Female'),
                            Radio(
                              value: 'Other',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      // Aksi untuk pilihan Other
                                    }
                                  : null,
                            ),
                            Text('Other'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // Aksi untuk berpindah halaman
        },
      ),
    );
  }
}
