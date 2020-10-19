import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String slug;
  final String title;
  final String category;
  final String description;
  final String productPhoto;
  final double price;
  final double dealerPrice;
  final String origin;
  final String typeOfProduct;
  final String measure;
  final double measureStep;
  bool isFavourite;
  bool isPopular;
  bool addedToCart;
  double quantity;


  Product({
    this.id,
    this.slug,
    this.title,
    this.category,
    this.description,
    this.productPhoto,
    this.price,
    this.dealerPrice,
    this.origin,
    this.typeOfProduct,
    this.measure,
    this.measureStep,
    this.isFavourite,
    this.isPopular,
    this.addedToCart,
    this.quantity,
  });

  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
