import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/transaction/detail_history.dart';

class HistoryScreen extends StatelessWidget {
  final List<Product> orderedProducts;
  final Map<String, dynamic> transactionData;

  HistoryScreen({required this.orderedProducts, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: orderedProducts.length,
        itemBuilder: (context, index) {
          final product = orderedProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHistoryScreen(
                    product: product,
                    transactionData: transactionData,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              ),
            ),
          );
        },
      ),
    );
  }
}