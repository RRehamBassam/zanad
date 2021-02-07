import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods{
  DatabaseMethods();
  signIn(String email, pass) async {
    print("statusCode =222222= 200");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'Mobile': email,
      'Password': pass,
      'ConfirmPassword': pass,
      'Name':email
    };
    var jsonResponse = null;
    var response = await http.post("https://api.zenadapp.com/api/Account/Login", body: data);
    if(response.statusCode == 200) {
      print("statusCode == 200");
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        print("yes");

        // setState(() {
        //   _isLoading = false;
        // });
       // sharedPreferences.setString("token", jsonResponse['token']);
       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      }
    }
    else {
      print("statusCode != 200");
      // setState(() {
      //   _isLoading = false;
      // });
      print(response.body);
    }
  }
}