import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/auth_provider.dart';
import 'package:max_cours_shop_app/providers/cart_provider.dart';
import 'package:max_cours_shop_app/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ListViewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final s = Scaffold.of(context);
    final _authData = Provider.of<AuthProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routName,
                arguments: product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              width: 200,
              height: 150,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
      ),
    );
  }
}
