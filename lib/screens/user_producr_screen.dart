import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/screens/edait_product_screen.dart';
import 'package:max_cours_shop_app/widgets/app_drawer.dart';
import 'package:max_cours_shop_app/widgets/user_prdouct_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refresh(BuildContext context)async{
    try{
    await Provider.of<ProductsProvider>(context,listen: false).fetchProducts(true);
    }catch(e){
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (ctx,dataSnapShot){
          if(dataSnapShot.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          } else if(dataSnapShot.error!=null){
           return Center(child:Text('Something wrong!,please try agin'));
          } else{
            return RefreshIndicator(
        onRefresh: ()=> _refresh(context),
              child: Consumer<ProductsProvider>(
                              builder:(ctx,productsData,_)=> Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                        productsData.items[i].id,
                        productsData.items[i].title,
                        productsData.items[i].imageUrl,
                      ),
                      Divider(),
                    ],
                  ),
          ),
        ),
              ),
      );
          }
        },
      ),
    );
  }
}


