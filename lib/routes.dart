import 'package:flutter/material.dart';
import 'package:jb_store/Pages/Auth/login.dart';
import 'package:jb_store/Pages/Profile/profile_page.dart';
import 'package:jb_store/Pages/home_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginPage(),
  '/profile': (context) => ProfileScreen(),
  '/home': (context) => HomeScreen(),
};
