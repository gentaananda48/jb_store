import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Set this to the index for Profile
  late Future<Map<String, dynamic>> _userData;
  bool _isEditing = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _userData = _apiService.getUser(2);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Navigate to categories page
        break;
      case 2:
        // Navigate to orders page
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? 'Save' : 'Edit Profile',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
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
                  const CircleAvatar(
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
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    readOnly: !_isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    readOnly: !_isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Email Id',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    readOnly: !_isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: locationController,
                    readOnly: !_isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Gender:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        // Aksi untuk pilihan Male
                                      });
                                    }
                                  : null,
                            ),
                            const Text('Male'),
                            Radio(
                              value: 'Female',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        // Aksi untuk pilihan Female
                                      });
                                    }
                                  : null,
                            ),
                            const Text('Female'),
                            Radio(
                              value: 'Other',
                              groupValue: 'Gender',
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        // Aksi untuk pilihan Other
                                      });
                                    }
                                  : null,
                            ),
                            const Text('Other'),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
