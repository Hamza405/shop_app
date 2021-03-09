import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class MyGridView extends StatelessWidget {
  final bool _showFavorite;
  MyGridView(this._showFavorite);
  
  @override
  Widget build(BuildContext context) {
     final productsData =  Provider.of<ProductsProvider>(context);
     final _products = _showFavorite? productsData.favoriteItem : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: _products[index],
        child: ProductItem(),
      )
    );
  }
}
