import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/auth_provider.dart';
import 'package:max_cours_shop_app/providers/cart_provider.dart';
import 'package:max_cours_shop_app/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context,listen: false);
    final cart = Provider.of<CartProvider>(context,listen: false);
    final s =Scaffold.of(context);
    final _authData = Provider.of<AuthProvider>(context);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
          child: GridTile(
        child: GestureDetector(
          onTap:() {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routName,arguments: product.id);
          },
                  child: Hero(
                    tag: product.id,
                                      child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
          ),
                  ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: Consumer<ProductModel>(
            builder: (context, product,child ) => IconButton(
              icon: Icon(product.isFavorite?Icons.favorite : Icons.favorite_border),
              onPressed: () async{
                try{
               await Provider.of<ProductModel>(context,listen: false).toggleFavoriteStatus(_authData.token,_authData.userId,);
               
                }catch( e){
                  print(e);
                  s.showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
              color: Theme.of(context).accentColor,
            ),
                      
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItemCart(product.id, product.price,product .title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Added item to Cart'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    },

                  ),
                )
              );
            },
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
