import 'dart:convert';
import 'package:ecommerce/models/products.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;

  HttpService({this.baseUrl = 'https://fakestoreapi.com'});

  Future<List<ProductModel>> getAllProducts(
    String endpoint,
    String? token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> postData(
    String endpoint,
    Map<String, dynamic> data,
    String? token,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<Map<String, dynamic>> putData(
    String endpoint,
    Map<String, dynamic> data,
    String? token,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<void> deleteData(String endpoint, String? token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );
      if (response.statusCode != 204) {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
