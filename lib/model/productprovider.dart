import 'package:appstree/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  final List<String> _selectedProductTitles = [];
  List<Product> get products => _products;
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            json.decode(response.body)['products'];
        _products = responseData.map((data) => Product.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void toggleProductSelection(String title) {
    if (_selectedProductTitles.contains(title)) {
      _selectedProductTitles.remove(title);
    } else {
      _selectedProductTitles.add(title);
    }
    notifyListeners();
  }

  bool isSelected(String title) {
    return _selectedProductTitles.contains(title);
  }
}
