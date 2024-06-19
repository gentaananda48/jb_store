import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  static const String _baseUrl = "https://fakestoreapi.com/users/";

  Future<Map<String, dynamic>> getUser(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl$id"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
