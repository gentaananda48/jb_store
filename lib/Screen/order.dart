// order_screen.dart

import 'package:flutter/material.dart';
import 'package:jb_store/Components/bottom_navbar.dart';
import 'package:jb_store/Components/drawer_widget.dart';
import 'package:jb_store/models/globals.dart';
import '../Models/product.dart';
import '../services/api_product.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<Product>> futureProducts;

  int _selectedIndex = 1; // Update initial index to 1

  @override
  void initState() {
    super.initState();
    futureProducts = ApiProduct().fetchProducts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _trackOrder(Product product) {
    // Add the product to history with "received" status
    historyOrderScreenStateKey.currentState?.addProductToHistory(product, "Received");
  }

  void _cancelOrder(Product product) {
    // Add the product to history with "canceled" status
    historyOrderScreenStateKey.currentState?.addProductToHistory(product, "Canceled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: SidebarDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Handle search input change
                print('Search term: $value');
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load products'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found'));
                  } else {
                    List<Product> products = snapshot.data!;
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTrack: () => _trackOrder(products[index]),
                          onCancel: () => _cancelOrder(products[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTrack;
  final VoidCallback onCancel;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTrack,
    required this.onCancel,
  }) : super(key: key);

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
              const Icon(
                Icons.inventory_outlined,
                size: 24.0,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('Category: 21 maret 2022'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.network(
                product.image,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${product.category}'),
                    Text("Price: \$${product.price}"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: onCancel,
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: onTrack,
                child: const Text("Finish"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}