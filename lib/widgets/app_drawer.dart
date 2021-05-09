import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:max_cours_shop_app/providers/auth_provider.dart';
import 'package:max_cours_shop_app/screens/order_screen.dart';
import 'package:max_cours_shop_app/screens/profile_screen.dart';
import 'package:max_cours_shop_app/screens/user_producr_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
              child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar(title:Text('Hello'),automaticallyImplyLeading: false,),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(height:10),
                  TextButton(child: Text('View My Profile'),onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProfileScreen()));
                  },)
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () => Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<AuthProvider>(context,listen: false).logout();
                
              },
            )
          ],
        ),
      ),
    );
  }

}