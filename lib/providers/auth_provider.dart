import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:max_cours_shop_app/model/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDateToken;

  String get userId => _userId;

  bool get isAuth {
    return token != null;
  }

  String get token{
    if(_token!=null&&_expiryDateToken!=null&&_expiryDateToken.isAfter(DateTime.now())){
      return _token;
    }
    return null;
  }
  Future<void> signUp(String email, String password) async {
   

    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> signIn(String email, String password)async{
    
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    Uri url =
       Uri.parse('https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyDDlP_tle8WGe6_-GdkeDHGaaAYXwO5Dms') ;
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDateToken=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}   
