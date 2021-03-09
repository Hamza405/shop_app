import 'package:flutter/widgets.dart';
import 'package:max_cours_shop_app/model/cart_model.dart';
import 'package:max_cours_shop_app/model/order_model.dart';

class Orderprovider with ChangeNotifier{
    List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartModel> cartProducts, double total) {
    _orders.insert(
      0,
      OrderModel(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}