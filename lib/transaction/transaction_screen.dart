import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';

class TransactionScreen extends StatefulWidget {
  final List<Product> cart;

  TransactionScreen({required this.cart});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  double calculateTotalPrice() {
    return widget.cart.fold(0, (total, current) => total + current.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Complete Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the complete address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Products:'),
              ...widget.cart.map((product) => ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(product.title),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.cart.isEmpty
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          // Clear the cart and navigate back to the detail screen
                          setState(() {
                            widget.cart.clear();
                          });

                          Navigator.pop(context);
                          Navigator.pop(context); 

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Transaction Complete')),
                          );// Pass true to indicate transaction completed
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Foreground color
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
