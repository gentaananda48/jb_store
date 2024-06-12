import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jb_store/models/product.dart';

//Mengambil data dari Fake Store API

class ApiService {
  final String apiUrl = "https://fakestoreapi.com/products";

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
}

