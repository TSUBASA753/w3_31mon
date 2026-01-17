import 'dart:convert';

import 'package:w3_31mon/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService{

    
  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(
        Uri.parse('https://6964b1fae8ce952ce1f28b0b.mockapi.io/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }else{
      throw Exception('หาไม่เจอ');
    }
  }

}