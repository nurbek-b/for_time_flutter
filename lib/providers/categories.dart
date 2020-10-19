import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Color bgColor = Color(0xfff5f5f5);
String mainUrl = "http://agrimatico-backend.ml/";

class Categories with ChangeNotifier{
  final String parent;
  final String title;
  final int id;
  final String slug;
  final growingTechnique;
  final List<Categories> children;

  Categories({this.parent, this.title, this.id, this.slug, this.growingTechnique, this.children});

  List<Categories> _categories = [];

  Future<void> fetchAndSetCategories()async{
    final categoriesUrl = "${mainUrl}en/api/v1/categories/";
    try {
      final response = await http.get(categoriesUrl);
      final categoriesData = json.decode(utf8.decode(response.bodyBytes));
      print("CATEGORIES DATA $categoriesData");
      final List<Categories> loadedCat = [];
      categoriesData?.forEach((cat){
        if (cat.parent == null) {
        } else {loadedCat.add(Categories(
            id: cat["id"],
            title: cat['title'],
            slug: cat['slug'],
            children: []
        ));
        cat['children']?.forEach((subCat){
          if (subCat == null){
          } else {loadedCat.last.children.add(Categories(
              id: subCat['id'],
              title: subCat['title'],
              slug: subCat['slug'],
              children: []
          ));
          subCat['children']?.forEach((miniSubCat){
            if (miniSubCat == null){
            } else {loadedCat.last.children.last.children.add(Categories(
                id: miniSubCat['id'],
                title: miniSubCat['title'],
                growingTechnique: subCat['growing_technique'],
                slug: miniSubCat['slug'],
                children: []
            ));
            }
          });
          }
        });
        }
      });
      _categories = loadedCat;
      print("CATEGORIES $_categories");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Categories> get categories{
    return [..._categories];
  }
}

