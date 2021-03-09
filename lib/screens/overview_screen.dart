import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/cart_provider.dart';
import 'package:max_cours_shop_app/widgets/app_drawer.dart';
import 'package:max_cours_shop_app/widgets/badge.dart';
import 'package:max_cours_shop_app/widgets/grid_view.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

enum FilterOption { Favorite, All }

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool _showFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selected) {
              setState(() {
                if (selected == FilterOption.Favorite) {
                  _showFavorite = true;
                } else {
                  _showFavorite = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOption.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (context, cartData, child) {
              return Badge(child: child, value: cartData.itemCount.toString());
            },
            child: IconButton(icon:Icon(Icons.shopping_cart),onPressed:()=> Navigator.of(context).pushNamed(CartScreen.routeName),),
          )
        ],
      ),
      body: MyGridView(_showFavorite),
      drawer: AppDrawer(),
    );
  }
}
