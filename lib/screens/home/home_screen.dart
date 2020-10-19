import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/Categories/categories.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/info_page/info_page.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexBar = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesScreen(),
    Text(
      'Favourites',
    ),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_indexBar],
      bottomNavigationBar: FloatingNavbar(
          backgroundColor: Color(0xFF1B5E20),
          selectedItemColor:Color(0xFF1B5E20),
        onTap: (int val) => setState(() => _indexBar = val),
        currentIndex: _indexBar,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: ''),
          FloatingNavbarItem(icon: Icons.menu, title: ''),
          FloatingNavbarItem(icon: Icons.shopping_cart, title: ''),
          FloatingNavbarItem(icon: Icons.perm_identity, title: ''),
        ],
      ),
    );
  }
}