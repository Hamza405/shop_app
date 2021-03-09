import 'dart:math';

import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/model/order_model.dart';
// import 'package:intl/intl.dart';


class OrderItem extends StatefulWidget {
  final OrderModel order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text('22/3/2020 6:23'
              // DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon( expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if(expanded)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
              height: min(widget.order.products.length * 20.0 + 100, 80),
              child: ListView(
                children: widget.order.products.map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      e.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${e.quantity} x \$${e.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                      ),
                    )
                    
                  ],
                )).toList(),
              ),
            )
          
        ],
      ),
    );
  }
}
