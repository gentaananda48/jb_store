// main.dart
import 'package:flutter/material.dart';
import 'package:jb_store/screen/orders_history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderHistoryPage(),
    );
  }
}
