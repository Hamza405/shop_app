import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/widgets/app_drawer.dart';
import 'package:max_cours_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';



class OrdersScreen extends StatefulWidget {
  static const routName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async{
      setState(() {
        _isloading = true;
      });
      try{
      await Provider.of<Orderprovider>(context, listen: false).fetchOrders();
      setState(() {
        _isloading = false;
      });
      }catch(e){
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text(e.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ));
                 setState(() {
        _isloading = false;
      });
        }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orderprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body:_isloading?Center(child:CircularProgressIndicator()) : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
