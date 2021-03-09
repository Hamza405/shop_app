
import 'package:flutter/foundation.dart';
import 'package:max_cours_shop_app/model/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _items={};
  Map<String, CartModel> get items => {..._items};
  int get itemCount =>  _items.length;
  
  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += (value.price * value.quantity) ;
     });
     return total;
  }

  void addItemCart(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartModel(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartModel(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String id){
    _items.remove(id);
    notifyListeners();
  }
}
