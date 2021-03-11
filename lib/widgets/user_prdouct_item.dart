import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/screens/edait_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'  as http;

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title, this.imageUrl);
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try{
                await Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
                }catch(e){
                  
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
