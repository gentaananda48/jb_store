import 'package:flutter/material.dart';
import 'package:jb_store/models/product.dart';
import 'package:jb_store/screen/all_product.dart';
import 'package:jb_store/screen/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Product> cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Store App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
      routes: {
        '/all-products': (context) => AllProductsScreen(cart: cart),
        '/register': (context) => const SignupScreen(),
      },
    );
  }
}
