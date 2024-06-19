import 'package:flutter/material.dart';
import 'package:jb_store/Screen/Auth/login.dart';
import 'package:jb_store/Screen/Profile/profile_page.dart';
import 'package:jb_store/Screen/home_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginPage(),
  '/profile': (context) => ProfileScreen(),
  '/home': (context) => HomeScreen(),
};
