import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Components/drawer_widget.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/transaction/detail_history.dart';

class HistoryScreen extends StatefulWidget {
  final List<Product> orderedProducts;
  final Map<String, dynamic> transactionData;

  HistoryScreen({required this.orderedProducts, required this.transactionData});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      drawer: SidebarDrawer(),
      body: ListView.builder(
        itemCount: widget.orderedProducts.length,
        itemBuilder: (context, index) {
          final product = widget.orderedProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHistoryScreen(
                    product: product,
                    transactionData: widget.transactionData,
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
                  fit: BoxFit.contain,
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
    );
  }
}