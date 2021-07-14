import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/widgets/category_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockProducts extends Mock implements ProductModel{}
List<ProductModel> products =[];

@GenerateMocks([http.Client])
class MockProductsProcider extends Mock implements ProductsProvider{
  
  @override
  Future<void> fetchProducts([bool filter = false])async{
    final client = MockClient((request){});
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/products.json');
    final response = await client.get(url);
    if(response.statusCode == 200){
      products = [
      ProductModel(
        id: '1',
        title: 'lolo',
        description: 'sdfsdfsd',
        imageUrl: 'asdfasdfsda',
        price: 12,
        isFavorite: false,
      ),
      ProductModel(
        id: '2',
        title: 'lolo',
        description: 'sdfsdfsd',
        imageUrl: 'asdfasdfsda',
        price: 12,
        isFavorite: false,
      ),
      ProductModel(
        id: '3',
        title: 'lolo',
        description: 'sdfsdfsd',
        imageUrl: 'asdfasdfsda',
        price: 12,
        isFavorite: false,
      )
      ];
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Future<void> deleteProduct (String id)async {

  }
}

void main(){
  MockProductsProcider _provider = MockProductsProcider();
  
  group('fetch products',(){
  test('fetch products success',()async{
    when(await _provider.fetchProducts()).thenAnswer((realInvocation) => null);
    expect( products.isEmpty,false);
  });
   test('fetch products :number of products',(){
    when(_provider.fetchProducts()).thenAnswer((realInvocation) => null);
    expect( products.length,3);
  });
  test('error on fetch',(){
     when(_provider.fetchProducts()).thenAnswer((realInvocation) => throw Exception());
     expect(Exception,Exception);
  });
  });

  test('add product',(){
    products.add(ProductModel(
      id: Random.secure().toString(),
      title: 'new product',
      description: 'this is text this is text',
      imageUrl: 'adfasdfdsfa',
      price: 1,
      isFavorite: false
    ));
    expect(products.length,1);
  });

  test('delete product',(){

  });
}