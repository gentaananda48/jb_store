// history_order.dart

import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/models/globals.dart';
import '../Models/product.dart';

class HistoryOrderScreen extends StatefulWidget {
  HistoryOrderScreen({Key? key}) : super(key: historyOrderScreenStateKey);

  @override
  HistoryOrderScreenState createState() => HistoryOrderScreenState();
}

class HistoryOrderScreenState extends State<HistoryOrderScreen> {
  int _selectedIndex = 2;
  List<Product> _historyProducts = [];
  Map<int, String> _status = {};

  void addProductToHistory(Product product, String status) {
    setState(() {
      _historyProducts.add(product);
      _status[product.id] = status;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _historyProducts.isEmpty
            ? const Center(child: Text('No history items found'))
            : ListView.builder(
                itemCount: _historyProducts.length,
                itemBuilder: (context, index) {
                  final product = _historyProducts[index];
                  final status = _status[product.id];
                  return HistoryProductCard(product: product, status: status!);
                },
              ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HistoryProductCard extends StatelessWidget {
  final Product product;
  final String status;

  const HistoryProductCard({Key? key, required this.product, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                product.image,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    Text("Price: \$${product.price}"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(status),
        ],
      ),
    );
  }
}