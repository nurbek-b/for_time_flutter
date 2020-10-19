import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/product.dart';

String mainUrl = "http://agrimatico-backend.ml/";


class Products with ChangeNotifier {
  List<Product> _items = [];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items].toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = '${mainUrl}en/api/v1/products/';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(utf8.decode(response.bodyBytes));
      final List<Product> loadedProducts = [];
      extractedData?.forEach((prod) {
        loadedProducts.add(Product(
          id: prod["id"].toString(),
          title: prod['title'],
          slug: prod['slug'],
          category: prod['category'],
          description: prod['description'],
          price: double.parse(prod['price']), 
          dealerPrice: double.parse(prod['diller_price']),
          origin: prod['origin'],
          typeOfProduct: prod['type_of_product'],
          productPhoto: prod['image'],
          measure: prod['measure'],
          measureStep: double.parse(prod['measureStep']),
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
