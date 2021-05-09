import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/screens/auth_screen.dart';
import 'package:max_cours_shop_app/screens/edait_product_screen.dart';
import 'package:max_cours_shop_app/screens/order_screen.dart';
import 'package:max_cours_shop_app/screens/overview_screen.dart';
import 'package:max_cours_shop_app/screens/product_details_screen.dart';
import 'package:max_cours_shop_app/screens/user_producr_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),

        // previousProductProvider.items == null
        //     ? []
        //     : previousProductProvider.items
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          update: (context, auth, previousProductProvider) =>
              ProductsProvider(auth.token, [],auth.userId),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<AuthProvider, Orderprovider>(
          update: (context, auth, previousOrderProvider) =>
              Orderprovider(auth.token, [],auth.userId),
        )
      ],
      child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    primarySwatch: Colors.green,
                    accentColor: Colors.red,
                    fontFamily: 'Lato'),
                home: auth.isAuth ? OverviewScreen() 
                :FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx,dataSnapShot)=>dataSnapShot.connectionState==ConnectionState.waiting?SplashScreen():AuthScreen(),
                ),
               
                routes: {
                  ProductDetailsScreen.routName: (context) =>
                      ProductDetailsScreen(),
                  CartScreen.routeName: (context) => CartScreen(),
                  OrdersScreen.routName: (context) => OrdersScreen(),
                  UserProductsScreen.routeName: (context) =>
                      UserProductsScreen(),
                  EditProductScreen.routeName: (context) => EditProductScreen()
                },
              )),
    );
  }
}
