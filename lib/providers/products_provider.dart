import 'dart:io';

import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _items = [];
  List<ProductModel> get items => [..._items];

  List<ProductModel> get favoriteItem =>
      [..._items].where((element) => element.isFavorite).toList();

  ProductModel findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<ProductModel> loadedProduct = [];
      extractData.forEach((key, value) {
        loadedProduct.add(ProductModel(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: value['isFavorite']));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addproduct(ProductModel product) async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));

      final newProduct = ProductModel(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);
      notifyListeners();
      print(newProduct.id);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> editproduct(String id, ProductModel newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      Uri url =
          Uri.parse('https://chat-room-2a579.firebaseio.com/products/$id.json');
      try{   
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
      }catch(e){
        throw e;
      }
    } else {
      return 'asd';
    }
  }

 
  
  Future<void> deleteProduct(String id) async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/products/$id.json');
    final productIndex = _items.indexWhere((element) => element.id == id);
    var existingProductIndex = _items[productIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);

      if(response.statusCode >= 400){
         _items.insert(productIndex, existingProductIndex);
      notifyListeners();
        throw HttpException('could not delete product!');
      }
    existingProductIndex = null;
  }
}
