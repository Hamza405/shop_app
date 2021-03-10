import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/screens/edait_product_screen.dart';
import 'package:max_cours_shop_app/screens/order_screen.dart';
import 'package:max_cours_shop_app/screens/overview_screen.dart';
import 'package:max_cours_shop_app/screens/product_details_screen.dart';
import 'package:max_cours_shop_app/screens/user_producr_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orderprovider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.red,
            fontFamily: 'Lato'),
        home: OverviewScreen(),
        routes: {
          ProductDetailsScreen.routName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routName:(context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName  : (context) => EditProductScreen()
        },
      ),
    );
  }
}
