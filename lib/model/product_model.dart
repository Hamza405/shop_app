import 'package:flutter/foundation.dart';
class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModel({this.id, this.title, this.description, this.price, this.imageUrl,this.isFavorite=false});

 toggleFavoriteStatus(){
  
      isFavorite = !isFavorite;
     notifyListeners();
  }
}