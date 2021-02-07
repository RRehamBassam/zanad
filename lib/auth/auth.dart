import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'ex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var MainUrl = 'https://api.zenadapp.com/api/';
   // var AuthKey ='Register';

   String Mobile;
   String Password;
  String ConfirmPassword;
  String Name;


  // Future<void> logout() async {
  //   _token = null;
  //   _userEmail = null;
  //   _userId = null;
  //   _expiryDate = null;
  //
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //     _authTimer = null;
  //   }
  //
  //   notifyListeners();
  //
  //   final pref = await SharedPreferences.getInstance();
  //   pref.clear();
  // }
  //
  // void _autologout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timetoExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timetoExpiry), logout);
  // }

  Future<bool> tryautoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
    json.decode(pref.getString('userData')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    Mobile = extractedUserData['Mobile'];
    Password = extractedUserData['Password'];
    ConfirmPassword = extractedUserData['ConfirmPassword'];
    Name = extractedUserData['Name'];
   // _expiryDate = expiryDate;
    notifyListeners();
   // _autologout();

    return true;
  }

  Future<void> Authentication(
      String email, String password, String endpoint) async {
    try {
      final url = '${MainUrl}/Account:${endpoint}?';

      final responce = await http.post(url,
          body: json.encode({
            'Mobile': email,
            'Password': password,
            'ConfirmPassword':password,
            'Name':email

          }));

      final responceData = json.decode(responce.body);
      print(responceData);
      if (responceData['error'] != null) {
        throw HttpException(responceData['error']['message']);
      }
      Mobile = responceData['Mobile'];
      Password = responceData['Password'];
      ConfirmPassword = responceData['ConfirmPassword'];
      Name= responceData['Name'];
      // _expiryDate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responceData['expiresIn'])));
      //
      // _autologout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'Mobile': Mobile,
        'Password': Password,
        'ConfirmPassword': ConfirmPassword,
        'Name':Name,
        //'expiryDate': _expiryDate.toIso8601String(),
      });

      prefs.setString('userData', userData);

      print('check' + userData.toString());
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) {
    return Authentication(email, password, 'Login');
  }

  Future<void> signUp(String email, String password) {
    return Authentication(email, password, 'Register');
  }
}