import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/transaction/history_screen.dart';

class DetailTransactionScreen extends StatelessWidget {
  final Map<String, dynamic> transactionData;
  final List<Product> products;
  final List<Product> cart;

  DetailTransactionScreen({
    required this.transactionData,
    required this.products,
    required this.cart,
  });

  void clearCart(BuildContext context) {
    // Simpan data produk yang dipesan
    final orderedProducts = List<Product>.from(cart);

    // Kosongkan cart
    cart.clear();

    // Navigasi ke halaman history
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          orderedProducts: orderedProducts,
          transactionData: transactionData,
        ),
      ),
    );

    // Tampilkan SnackBar untuk konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction Complete')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Table(
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['name']}'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['email']}'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['address']}'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['phone']}'),
                    ),
                  ]),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final product = cart[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Payment Detail',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Table(
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': \$${transactionData['total'].toStringAsFixed(2)}'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['paymentMethod']}'),
                    ),
                  ]),
                  if (transactionData['paymentMethod'] == 'PayPal')
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('PayPal Number', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(': ${transactionData['paypalNumber']}'),
                      ),
                    ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Payment Status', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(': ${transactionData['paymentStatus']}'),
                    ),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => clearCart(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text('Submit My Purchase'),
        ),
      ),
    );
  }
}