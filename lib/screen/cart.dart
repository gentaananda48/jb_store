import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = widget.cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      Product product = widget.cart[index];
                      return ListTile(
                        leading: Image.network(product.image, fit: BoxFit.cover, width: 50),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            setState(() {
                              widget.cart.removeAt(index); //Mengapus items dari cart
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add logic to proceed to checkout
                      },
                      child: const Text('Checkout', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
