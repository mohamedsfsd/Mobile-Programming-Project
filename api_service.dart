import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$category'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by category: ${response.statusCode}');
    }
  }
}