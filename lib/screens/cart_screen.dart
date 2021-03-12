import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/cart_provider.dart';
import 'package:max_cours_shop_app/providers/order_provider.dart';
import 'package:max_cours_shop_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
   static const routeName = '/cart';

  @override
  Widget build(BuildContext context){
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPrice.toStringAsFixed(3)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isloading =false;
  
  @override
  Widget build(BuildContext context) {
    final s = Scaffold.of(context);
    return _isloading ?Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircularProgressIndicator(),
    ): FlatButton(
      child: Text('ORDER NOW'),
      onPressed:((widget.cart.totalPrice <= 0)|| _isloading )? null : () async {
        setState(() {
          _isloading = true;
        });
        try{
        await Provider.of<Orderprovider>(context,listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalPrice);
        setState(() {
          _isloading = false;
        });
        widget.cart.clearCart();
        }catch(e){
          s.showSnackBar(
            SnackBar(content: Text('${e.toString()}'))
          );
          setState(() {
          _isloading = false;
        });
        }
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}