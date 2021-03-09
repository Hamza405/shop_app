import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/widgets/app_drawer.dart';
import 'package:max_cours_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';



class OrdersScreen extends StatelessWidget {
  static const routName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orderprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
