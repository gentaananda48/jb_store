import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
// import 'package:jb_store/transaction/detail_transaction.dart';

class TransactionScreen extends StatefulWidget {
  final List<Product> cart;

  TransactionScreen({required this.cart});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _transactionData = {
    'name': '',
    'email': '',
    'address': '',
    'phone': '',
    'total': 0.0,
    'paymentMethod': '',
    'paypalNumber': '',
  };
  String selectedPaymentMethod = '';
  TextEditingController paypalController = TextEditingController();
  bool showPaypalField = false;

  @override
  void initState() {
    super.initState();
    _transactionData['total'] = widget.cart.fold(0.0, (sum, item) => sum + item.price);
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (selectedPaymentMethod.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a payment method'),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      }
      if (selectedPaymentMethod == 'PayPal' && paypalController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter your PayPal number'),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      }
      _transactionData['paymentMethod'] = selectedPaymentMethod;
      _transactionData['paypalNumber'] = paypalController.text;
      // Navigator.push(
      //  context,
      //  MaterialPageRoute(
      //    builder: (context) => DetailTransactionScreen(
      //      transactionData: _transactionData,
      //      products: widget.cart,
      //      cart: widget.cart,
      //    ),
      //  ),
      // );
    }
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
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _transactionData['name'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  _transactionData['email'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  _transactionData['address'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) {
                  _transactionData['phone'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Products:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...widget.cart.map((product) => ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  )),
              SizedBox(height: 20),
              Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('PayPal'),
                leading: Radio<String>(
                  value: 'PayPal',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                      showPaypalField = true;
                    });
                  },
                ),
              ),
              if (showPaypalField)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: paypalController,
                    decoration: InputDecoration(labelText: 'PayPal Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (selectedPaymentMethod == 'PayPal' && (value == null || value.isEmpty)) {
                        return 'Please enter your PayPal number';
                      }
                      return null;
                    },
                  ),
                ),
              ListTile(
                title: const Text('COD (Cash on Delivery)'),
                leading: Radio<String>(
                  value: 'COD',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                      showPaypalField = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total: \$${_transactionData['total'].toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}