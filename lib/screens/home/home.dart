import 'package:flutter/material.dart';
import 'package:shop_app/screens/Categories/categories.dart';
import 'package:shop_app/size_config.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.0,),
              Text("Скотоводство", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              SizedBox(height: 15.0,),
              InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset('assets/main_page/cow.jpeg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.60),
                ),
              ),
              SizedBox(height: 40.0,),
              Text("Агрономия", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              SizedBox(height: 15.0,),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CategoriesScreen.routeName);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset('assets/main_page/mainagri.jpeg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.60),
                ),
              ),
            ],
          ),
        )
    );
  }
}
