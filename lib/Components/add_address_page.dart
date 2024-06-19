import 'package:flutter/material.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Flat No. Street Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Landmark'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a landmark';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pincode'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pincode';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City/District'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city or district';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Address Type'),
              ListTile(
                title: const Text('Home'),
                leading: Radio(
                  value: 'home',
                  groupValue:
                      'home', // Update this to reflect the selected value
                  onChanged: (value) {
                    setState(() {
                      // Update the state with the selected value
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Office'),
                leading: Radio(
                  value: 'office',
                  groupValue:
                      'home', // Update this to reflect the selected value
                  onChanged: (value) {
                    setState(() {
                      // Update the state with the selected value
                    });
                  },
                ),
              ),
              CheckboxListTile(
                title: const Text('Use as default address'),
                value: false, // Update this to reflect the selected value
                onChanged: (bool? value) {
                  setState(() {
                    // Update the state with the selected value
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                  }
                },
                child: Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
