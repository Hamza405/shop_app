import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:max_cours_shop_app/model/cart_model.dart';
import 'package:max_cours_shop_app/model/http_exception.dart';
import 'package:max_cours_shop_app/model/order_model.dart';
import 'package:http/http.dart' as http;

class Orderprovider with ChangeNotifier{
    List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders()async{
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/orders.json');
    try{
    final response = await http.get(url);
    if(response.statusCode >= 400){
      throw HttpException('Something wrong!').toString();
    }
    final List<OrderModel> fetchedOrders = [];
    var extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((key, value) { 
      fetchedOrders.add(OrderModel(id: key, amount: value['amount'], dateTime: DateTime.parse(value['dateTime']),
        products: (value['products'] as List<dynamic>).map((e)=>CartModel(
          id: e['id'],
          price: e['price'],
          quantity: e['quantity'],
          title: e['title']
        ) ).toList()
    ));
    });
    _orders = fetchedOrders;
    notifyListeners();
    
    }catch(e){
      throw HttpException('Something wrong!').toString();
    }
  }

  Future<void> addOrder(List<CartModel> cartProducts, double total) async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/orders.json');
    final timeStamp = DateTime.now();
    try{
    final response = await http.post(url,body:json.encode({
       'amount':total,
       'dateTime':timeStamp.toIso8601String(),
       'products':cartProducts.map((cp) => {
         'id' : cp.id,
         'title': cp.title,
         'price':cp.price,
         'quantity':cp.quantity

       }).toList(),
     }) );
     
    _orders.insert(
      0,
      OrderModel(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
    }catch(e){
      throw HttpException('Something wrong!').toString();
    }
  }
}