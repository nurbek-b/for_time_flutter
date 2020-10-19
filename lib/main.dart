import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Categories()),
        ],
      child: Consumer<Auth>(builder: (ctx, auth, _) =>MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Агриматико',
          theme: theme(),
          routes: routes,
          home: auth.isAuth ? HomeScreen() : SplashScreen(),
          )
        )
      );
  }
}
