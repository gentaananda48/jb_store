import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/product.dart';

//Mengambil data dari Fake Store API

class ApiProduct {
  final String apiUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> fetchProducts({String? category}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
