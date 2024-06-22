import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/screen/cart.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  final List<Product> cart; // Meletakkan cart list ke detail screen

  DetailScreen({required this.product, required this.cart});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? selectedSize;
  Color? selectedColor;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            // Mengubah warna icon ke merah ketika di klik
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cart: widget.cart)), // Membuka cart.dart screen
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(widget.product.image, height: 300, fit: BoxFit.scaleDown),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Text('4.1', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 8),
                            Text('87 Reviews', style: TextStyle(fontSize: 16, color: Colors.grey)),
                            // Review disini cuman dummy
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.product.price}',
                          style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        _buildProductOptions(),
                        const SizedBox(height: 16),
                        _buildProductSizes(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildProductOptions() {
    if (widget.product.category == 'electronics') {
      // Builder option untuk kategori electronics
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildColorOption(Colors.white),
              _buildColorOption(Colors.black),
              _buildColorOption(Colors.blue),
              _buildColorOption(Colors.red),
            ],
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildColorOption(Color color) {
    bool isSelected = selectedColor == color;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = color;
          });
        },
        child: CircleAvatar(
          backgroundColor: color,
          radius: 15,
          child: isSelected
              ? const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 12,
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildProductSizes() {
    if (widget.product.category == 'men\'s clothing' || widget.product.category == 'women\'s clothing') {
      //Builder option untuk kategori men's clothing dan women's clothing
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Size:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildSizeOption('S'),
              _buildSizeOption('M'),
              _buildSizeOption('L'),
              _buildSizeOption('XL'),
              _buildSizeOption('XXL'),
            ],
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSize = size;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey),// Fungsi untuk perubahan warna ketika option di klik
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            size,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Mengubah radius border
            ),
          ),
          ),
          onPressed: () {
            setState(() {
              widget.cart.add(widget.product); // Menambahkan items ke cart
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to cart'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
