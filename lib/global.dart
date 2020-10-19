import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

Color bgColor = Color(0xfff5f5f5);


class Categories {
  final String title;
  final int id;
  final List<SubCategories> subCat;

  Categories(this.title, this.id, [this.subCat = const <SubCategories>[]]);
}

class SubCategories {
  final String title;
  final int id;
  final List<MiniSubCategories> miniSubCat;

  SubCategories(this.id, this.title, [this.miniSubCat = const <MiniSubCategories>[]]);
}


class MiniSubCategories {
  final String title;
  final int id;
  final List<Product> products;

  MiniSubCategories(this.id, this.title, [this.products = const <Product>[]]);
}

List<Categories> categories = [
  Categories("Овощи", 1, [
      SubCategories(1, "Помидор", [
          MiniSubCategories(1, "Семена", [
            Product(id: '1', slug: 'Семена-1', title: 'Семена-1', description: 'description-1',
                origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
                isFavourite:false, addedToCart:false, quantity: 1),
            Product(id: '2', slug: 'Семена-2', title: 'Семена-2', description: 'description-2',
                origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
                isFavourite:false, addedToCart:false, quantity: 1),
          ]),
        MiniSubCategories(1, "Химия", [
          Product(id: '1', slug: 'Химия-1', title: 'Химия-1', description: 'description-1',
              origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
              isFavourite:false, addedToCart:false, quantity: 1),
          Product(id: '2', slug: 'Химия-2', title: 'Химия-2', description: 'description-2',
              origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
              isFavourite:false, addedToCart:false, quantity: 1),
        ]),
      ]),
    SubCategories(1, "Кортошка", [
      MiniSubCategories(1, "Семена", [
        Product(id: '1', slug: 'Семена-1', title: 'Семена-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Семена-1', title: 'Семена-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
      MiniSubCategories(1, "Химия", [
        Product(id: '1', slug: 'Химия-1', title: 'Химия-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Химия-2', title: 'Химия-', description: 'description-2',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
    ]),
  ]),
  Categories("Фрукты", 1, [
    SubCategories(1, "Яблоко", [
      MiniSubCategories(1, "Семена", [
        Product(id: '1', slug: 'Семена-1', title: 'Семена-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Семена-2', title: 'Семена-2', description: 'description-2',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
      MiniSubCategories(1, "Химия", [
        Product(id: '1', slug: 'Химия-1', title: 'Химия-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Химия-2', title: 'Химия-2', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
    ]),
    SubCategories(1, "Банан", [
      MiniSubCategories(1, "Семена", [
        Product(id: '1', slug: 'Семена-1', title: 'Семена-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Семена-2', title: 'Семена-2', description: 'description-2',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
      MiniSubCategories(1, "Химия", [
        Product(id: '1', slug: 'Химия-1', title: 'Химия-1', description: 'description-1',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
        Product(id: '2', slug: 'Химия-2', title: 'Химия-2', description: 'description-2',
            origin: "Russia", dealerPrice: 25.0, price: 35.0, productPhoto:'assets/images/image-1.jpeg',
            isFavourite:false, addedToCart:false, quantity: 1),
      ]),
    ]),
  ])
];

