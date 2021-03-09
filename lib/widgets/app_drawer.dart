import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:max_cours_shop_app/screens/order_screen.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title:Text('Hello'),automaticallyImplyLeading: false,),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routName),
          )
        ],
      ),
    );
  }

}