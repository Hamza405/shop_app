import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:max_cours_shop_app/model/http_exception.dart';
import 'package:max_cours_shop_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final String keyUserData = 'userData';
  UserModel _user;
  UserModel get user => _user;
  String _token;
  String _userId;
  DateTime _expiryDateToken;
  Timer _authTimer;

  String get userId => _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDateToken != null &&
        _expiryDateToken.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String password, String userName,
      String phoneNumber) async {
    return _authenticate(
        email: email,
        password: password,
        urlSegment: 'accounts:signUp',
        userName: userName,
        phoneNumber: phoneNumber);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(
        email: email,
        password: password,
        urlSegment: 'accounts:signInWithPassword');
  }

  Future<void> _authenticate(
      {String email,
      String password,
      String userName,
      String phoneNumber,
      String urlSegment}) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyDDlP_tle8WGe6_-GdkeDHGaaAYXwO5Dms');
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
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDateToken = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      if (urlSegment == 'accounts:signUp')
        _addUserToDatabase(userName, phoneNumber, email);
      if(urlSegment == 'accounts:signUp') _getUserInfo(email);
      print(_user);  
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'email':email,
        '_expiryDate': _expiryDateToken.toIso8601String()
      });
      prefs.setString(keyUserData, userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        await json.decode(prefs.getString(keyUserData)) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['_expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDateToken = expiryDate;
    String email = extractedUserData['email'];
    _getUserInfo(email);
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> _getUserInfo(String email) async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/users.json?auth=$token');
    try{
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    var s = data.entries.firstWhere((element) => element.value['email']==email);
    _user = UserModel(
        email: s.value['email'],
        userName: s.value['userName'],
        phoneNumber: s.value['phoneNumber']);
    print(_user.userName);
    }catch(e){
      throw e;
    }
  }

  Future<void> _addUserToDatabase(
      String name, String phoneNumber, String email) async {
    Uri url = Uri.parse('https://chat-room-2a579.firebaseio.com/users.json?auth=$token');
    try {
      final response = await http.post(url,
          body: json.encode(
              {'userName': name, 'phoneNumber': phoneNumber, 'email': email}));
      _user = UserModel(userName:name,email: email,phoneNumber: phoneNumber);
    } catch (e) {
      throw e;
    }
  }

  void logout() async {
    _token = null;
    _expiryDateToken = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    var expiryDate = _expiryDateToken.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiryDate), logout);
  }
}
