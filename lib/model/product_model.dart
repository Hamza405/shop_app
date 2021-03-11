import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModel({this.id, this.title, this.description, this.price, this.imageUrl,this.isFavorite=false});

 Future<void> toggleFavoriteStatus()async{
   final oldStatue = isFavorite;
    isFavorite = !isFavorite;
     notifyListeners();
   Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/products/$id.json');
    try{
   final response = await http.patch(url,body:json.encode({
     'isFavorite':isFavorite
   }));
   if(response.statusCode >= 400){
     isFavorite = oldStatue;
     notifyListeners();
   
     throw HttpException('Something wrong try agin later!');
   }
    }catch(e){
      isFavorite = oldStatue;
     notifyListeners();
     throw e;
    }
    
  }
}