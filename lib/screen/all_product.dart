import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/screen/detail_screen.dart';
import 'package:jb_store/services/api_services.dart';

class AllProductsScreen extends StatefulWidget {
  final List<Product> cart;

  AllProductsScreen({required this.cart});

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService().fetchProducts(); //Memanggil semua product dari API Fake Store
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              //List akam berupa gridview dengan 2 buah item dalam satu baris horizontal
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                double? discountPercentage;
                if (product.originalPrice != null && product.originalPrice! > product.price) {
                  discountPercentage = ((product.originalPrice! - product.price) / product.originalPrice!) * 100;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(product: product, cart: widget.cart), //Mengarahkan ke details.dart
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    child: Column(
                      children: [
                        Image.network(product.image, height: 150, fit: BoxFit.scaleDown),
                        const SizedBox(height: 8),
                        Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),                        
                        if (discountPercentage != null)
                          Text(
                            '\$${product.originalPrice!.toStringAsFixed(2)} ${discountPercentage.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load products'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
