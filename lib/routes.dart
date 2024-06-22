import 'package:flutter/material.dart';
import 'package:jb_store/screen/Auth/login.dart';
import 'package:jb_store/screen/Profile/profile_page.dart';
import 'package:jb_store/screen/all_product.dart';
import 'package:jb_store/screen/home_screen.dart';
import 'package:jb_store/screen/signup_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginPage(),
  '/profile': (context) => ProfileScreen(),
  '/home': (context) => HomeScreen(),
  '/all-products': (context) => AllProductsScreen(),
  '/register': (context) => SignupScreen(),
};
