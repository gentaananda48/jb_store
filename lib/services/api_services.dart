import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jb_store/models/product.dart';
import 'package:jb_store/models/user.dart'; // Pastikan Anda memiliki model User

// Mengambil data dari Fake Store API

class ApiService {
  final String apiUrl = "https://fakestoreapi.com/products";
  final String userApiUrl = "https://fakestoreapi.com/users";

  Future<List<Product>> fetchProducts({String? category}) async {
    String url = apiUrl;
    if (category != null) {
      url = "$apiUrl/category/$category";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<User> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(userApiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register user');
    }
  }
}
