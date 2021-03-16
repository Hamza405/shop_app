import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/widgets/app_drawer.dart';
import 'package:max_cours_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routName = '/orders';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orderprovider>(context,listen: false).fetchOrders(),
          builder: (ctx, dataSnapShot) {
              if(dataSnapShot.connectionState==ConnectionState.waiting){
                return Center(child:CircularProgressIndicator());
              } else{
                if(dataSnapShot.error !=null){
                  return Center(child:Text('Something wrong try agin!'));
                }
                if(dataSnapShot.hasData==null){
            return Center(child: Text('You dont have any orders!'),);
          }
              return Consumer<Orderprovider>(builder: (ctx,orderData,child)=> ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
              ));
            }}
          
        ));
  }
}

// isloading?Center(child:CircularProgressIndicator()) : ListView.builder(
//         itemCount: orderData.orders.length,
//         itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
//       ),
