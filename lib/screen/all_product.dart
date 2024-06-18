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
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    products = ApiService().fetchProducts(); // Mengambil semua data produk dari API Fake Store
  }

  void _filterProducts(String? category) {
    //Fungsi untuk meng-handle filter berdasarkan kategori
    setState(() {
      selectedCategory = category;
      products = ApiService().fetchProducts(category: category);
    });
  }

  String capitalizeWords(String input) {
    // Agar text menjadi Capitalize each word
    return input.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Product List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Categories : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 15,),
                DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text("Filter by Category"),
                  items: <String>[
                    // Menampilkan filter untuk produk
                    'All',
                    'electronics',
                    'jewelery',
                    "men's clothing",
                    "women's clothing",
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value == 'All' ? null : value,
                      child: Text(capitalizeWords(value)),
                    );
                  }).toList(),
                  onChanged: _filterProducts,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Memberikan loading screen ketika proses fetching produk dari API
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load products')); // Apa bila gagal fetch, maka akan me-return ini
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    // Fetching berhasil
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //Dalam satu baris menampilkan 2 produk
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
                              builder: (context) => DetailScreen(product: product, cart: widget.cart), // Navigasi ke detail_screen.dart
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Menempatkan text ke "start" agar tampilan lebih enak dilihat 
                            children: [
                              Center(
                                child: Image.network(product.image, height: 150, fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis), // overFlow agar text yang melewati batas akan diubah menjadi elipsis
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                child: Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              if (discountPercentage != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    '\$${product.originalPrice!.toStringAsFixed(2)} ${discountPercentage.toStringAsFixed(0)}% OFF',
                                    style: const TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No products available')); // Apabila tidak ada produk di API
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}