import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
class AuthService {
  final baseUrl = 'http://localhost:4000';
  // ignore: non_constant_identifier_names
  static final SESSION = FlutterSession();

  Future<dynamic> register(String Mobile, String Password) async {
    print("yes111");

    try {
      var res = await http.post('https://api.zenadapp.com/api/Account/Register', body: {
        'Mobile': Mobile,
        'Password': Password,
        'ConfirmPassword': Password,
        'Name':Mobile
      });
      print("yes");

      return res?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var res = await http.post(
        'https://api.zenadapp.com/api/Account/Register',
        body: {
          'email': email,
          'password': password,
          'token': 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        },
      );

      return res?.body;
    } finally {
      // you can do somethig here
    }
  }

  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken()async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String token, refreshToken, clientId;
  _AuthData(this.token, this.refreshToken, {this.clientId});

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['clientId'] = clientId;
    return data;
  }
}
