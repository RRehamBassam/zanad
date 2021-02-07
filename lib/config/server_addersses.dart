import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zanad_app/config/HelperFunctions.dart';

class ServerAddresses {
  //https://zenadapp.com/ZenadApi/
  static const serverAddress = 'https://zenadapp.com/ZenadApi/';

  static const _woocommerceKeys = '';
  static const _categorySuffix = '/wp-json/wc/v3/products/categories/'; //id
  static const _productSuffix = ' /wp-json/wc/v3/products/categories/';
  static const _promoSuffix = ' /wp-json/wc/v3/reports/coupons/';
  // TODO need an endpoint for this

  void main(List<String> arguments) async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  Future<dynamic> signUp(String name,String Mobile, String Password) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Account/Register';

    Map map ={
      'Name':name,
      'Mobile': Mobile,
      'Password': Password,
      'ConfirmPassword': Password,
     };
    var itemCount ;
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
     print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    if (reply == "Name +966111122222 is already taken.") {
      itemCount="Name +966111122222 is already taken.";
    }else{
     itemCount = jsonResponse['result'];}

    dynamic itemCount2 = jsonResponse;

    HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;
    print(itemCount);


    // print("1");
    // var url = 'https://api.zenadapp.com/api/Account/Register';
    // print("2");
    // var response = await http.post(url,body: {
    //   'Name':"reham",
    //   'Mobile': "+96656123456",
    //   'Password': "123456",
    //   'ConfirmPassword': "123456",
    // });
    // print("3");
    // if (response.statusCode == 200) {
    //   print("yes");
    //   var jsonResponse = convert.jsonDecode(response.body);
    //   var itemCount = jsonResponse['Message'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.rrrrrrrrrrr');
    // }
  }
  Future<dynamic> Services() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Services';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount[0]['id']);
    return itemCount;
    // var jsonResponse = convert.jsonDecode(reply);
    // var itemCount = jsonResponse['result'];
    // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    // print(itemCount);
  }
  Future<dynamic> AddRequest(int ServiceId,String ChoosedLocationsId, int PaymentMethodId,String UserId, String note,String priority, String Attachmentimg,String NewServiceName,addresses) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/AddRequest';
    Map map ={
      "GovermentDepId": 5,
      "ServiceId": ServiceId,
      "ChoosedLocationsId": 57,
      "PaymentMethodId": PaymentMethodId,
      "UserId": UserId,
      "priority": "$priority",
      "note": "$note",
      "address": "$addresses",
      "timeFrom": "00:00:00.1234567",
      "timeTo": "00:00:00.1234567",
      "attachment": "$Attachmentimg",
      "isNewServiceName": true,
      "NewServiceName": NewServiceName
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');

    request.add(convert.utf8.encode(convert.json.encode(map)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    print("reply");
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    return itemCount;
   // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    print(itemCount);

  }
  Future<void> Logout() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Account/logout';

    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');
    HelperFunctions.saveUserIdSharedPreference(null);
    HelperFunctions.saveUserNameSharedPreference(null);
    HelperFunctions.saveUserMobileSharedPreference(null);
    HelperFunctions.saveUserIsRecevidSharedPreference(null);

  //  request.add(convert.utf8.encode(convert.json.encode(map)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(convert.utf8.decoder).join();

    print("yes");
    print(reply);

    // print("1");
    // var url = 'https://api.zenadapp.com/api/Account/Register';
    // print("2");
    // var response = await http.post(url,body: {
    //   'Name':"reham",
    //   'Mobile': "+96656123456",
    //   'Password': "123456",
    //   'ConfirmPassword': "123456",
    // });
    // print("3");
    // if (response.statusCode == 200) {
    //   print("yes");
    //   var jsonResponse = convert.jsonDecode(response.body);
    //   var itemCount = jsonResponse['Message'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.rrrrrrrrrrr');
    // }
  }
  Future<void> IsAbsherNumber(String Mobile,bool IsSamePhoneNumber ) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/IsAbsherNumber';
    Map map ={
      "IsSamePhoneNumber": IsSamePhoneNumber,
      "AbsherNumber": Mobile,
      "UserId": "2337e4c7-b772-4df2-a8f0-8aac84d6dfdc"
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    if (response.statusCode == 200) {
      print("yes");
    }

  }
  Future<void> AddAttachment2(String Image,String ext ) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/AddAttachment2';
    Map map ={
      "Image": Image,
      "ext": ext,
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    if (response.statusCode == 200) {
      print("yesAddAttachment2");
    }

  }
  Future<dynamic> AboutUs() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/AboutUs';

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    if (response.statusCode == 200) {
      print("yes");
    }
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;
  }
  Future<void> paymentTypes() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/paymentTypes';

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    if (response.statusCode == 200) {
      print("yes");
    }

  }
  Future<dynamic> RequestActivation(String id,String ActiationCode) async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest  request =
    await client.getUrl(Uri.parse('${serverAddress}api/RequestActivation'));
    HttpClientResponse response = await request.close();
    Map map ={
      "UserId": id,
    "ActiationCode": ActiationCode
    };
    request.add(convert.utf8.encode(convert.json.encode(map)));
    String reply = await response.transform(convert.utf8.decoder).join();
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    return itemCount;
  }
  Future<void> SendActivationCode(String id) async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest  request =
    await client.postUrl(Uri.parse('${serverAddress}api/SendActivationCode?userId=$id'));
    HttpClientResponse response = await request.close();

    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("yes");
      //return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
 //
  Future<dynamic> signIn(String Mobile, String Password) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Account/Login';
    Map map ={
      'UserName':Mobile,
      'Password':Password,
    };
 //   HelperFunctions.saveUserNameSharedPreference("");
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse['result'];
    print(jsonResponse['result']);
    return itemCount;

  }
  Future<void> forgotPassword(String Mobile) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Account/ForgotPassword';
    Map map ={
      'Mobile': "+96656123456",
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
      HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
  }
  Future<dynamic> FindUser(String mobile,String pass) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Account/FindUser';
    Map map ={
      'UserName':mobile,
      'Password':pass,
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();

    var reply = (await response.transform(convert.utf8.decoder).join()) ;
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    dynamic itemCount2 = jsonResponse;
    if (itemCount2.length==1) {
      print("good");
      return itemCount2['result'];
    }
   print(mobile);
    print(pass);
    HelperFunctions.saveUserIdSharedPreference(itemCount['UserId']);
    HelperFunctions.saveUserNameSharedPreference(itemCount['Name']);
    HelperFunctions.saveUserMobileSharedPreference(itemCount['Mobile']);
    HelperFunctions.saveUserIsRecevidSharedPreference(itemCount['Role']);
    print("good");
    print(itemCount['UserId']);
    return itemCount;
    // print("yes");
    // print(itemCount[0]['Mobile']);

    // if (response.statusCode == 200) {
    //   return reply.info[0];
    // }
    //  return null;

  }
  Future<dynamic> Profile(String Id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Profiles/${Id}';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    var reply = (await response.transform(convert.utf8.decoder).join()) ;
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;
    // print("yes");
    // print(itemCount[0]['Mobile']);

    // if (response.statusCode == 200) {
    //   return reply.info[0];
    // }
    //  return null;

  }


  Future<void> updateProfile(String UserId, String FullName, String IdentityImg,String Email, String AbsherNumber,String City,String Image) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/updateProfile';
    Map map={
     'UserId':UserId,
     'FullName':FullName,
     'IdentityImg':"",
     'IdentityImgchange':true,
     'ImgPhoto':Image,
     'ImgPhotoChange':true,
     'IdentityNumber':1,
     'City':City,
     'UserLocationId':57,
     'AbsherImg':"",
     'AbsherImgChange':true,
     'Email':Email,
     'IsSamePhoneNumber':false,
     'AbsherNumber':AbsherNumber};
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
     request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yesupdateProfile");
    print(reply);
    print(response.statusCode);

    // print("1");
    // var url = 'https://api.zenadapp.com/api/Account/Register';
    // print("2");
    // var response = await http.post(url,body: {
    //   'Name':"reham",
    //   'Mobile': "+96656123456",
    //   'Password': "123456",
    //   'ConfirmPassword': "123456",
    // });
    // print("3");
    // if (response.statusCode == 200) {
    //   print("yes");
    //   var jsonResponse = convert.jsonDecode(response.body);
    //   var itemCount = jsonResponse['Message'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.rrrrrrrrrrr');
    // }
  }
  Future<dynamic> Search(String UserId,String SearchWord) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Search';
    Map map ={
      'UserId': UserId,
      'SearchWord':SearchWord
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;
  }
  Future<dynamic> connectData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/supportConnectData';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;
  }

  Future<dynamic> ServicesDetails(int ServicesId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Services/${ServicesId}';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;

  }
  Future<void> addAddress(String UserId, String Long, String Lat) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/addAddress';
    Map map={
      "Long":Long,
      "Lat": Lat,
      "UserId": UserId,
      "Note": "Note",
      "Id": 5
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yesupdateProfile");
    print(reply);
    print(response.statusCode);

  }
  Future<dynamic> NotificationsUser(String userId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Notifications?UserId=${userId}';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;

  }

}

class Note {
  String Message;
  Note(this.Message);
}

class User {
  String Name;
  String Mobile;
  String Password;
  String ConfirmPassword;
  User({this.Mobile, this.Password, this.ConfirmPassword, this.Name});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Name: json['Name'],
      Mobile: json['Mobile'],
      Password: json['Password'],
      ConfirmPassword: json['ConfirmPassword'],
    );
  }

}
class sign{
  String result;

  sign({this.result});

  factory sign.fromJson(Map<String, dynamic> json) {
    return sign(
      result: json['result'],
    );
  }
}
class UserS {
  String access_token;
  String token_type;
  String expires_in;
  String Mobile;
  String Name;
  String Role;
  String UserId;
  String isActive;
  String issued;
  String expires;
  UserS({
      this.access_token,
      this.token_type,
      this.expires_in,
      this.Mobile,
      this.Name,
      this.Role,
      this.UserId,
      this.isActive,
      this.issued,
      this.expires});

  factory UserS.fromJson(Map<String, dynamic> json) {
    return UserS(
      access_token: json['token_type'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
      Mobile: json['Mobile'],
      Name: json['Name'],
      Role: json['Role'],
      UserId: json['UserId'],
      issued: json['issued'],
      expires: json['expires'],

    );
  }}
class UserSs {
  String UserName;
  String Password;
  UserSs({this.Password, this.UserName});



  factory UserSs.fromJson(Map<String, dynamic> json) {
    return UserSs(
      UserName: json['UserName'],
      Password: json['Password'],

    );
  }}
class UserSS{
  final String Mobile;
  final String FullName;
  final String AbsuerNumber;
  final String Email;
  final String IdentityImg;
  final String AbsherImg;
  final String UserPhohot;
  final String City;
  final String IdentityNumber;
  final String ImgPhotoFromApi;
  final  String IdentityImgFromApi;
  final String AbsherImgFromApi;
  final String Role;

  UserSS(
      this.Mobile,
      this.FullName,
      this.AbsuerNumber,
      this.Email,
      this.IdentityImg,
      this.AbsherImg,
      this.UserPhohot,
      this.City,
      this.IdentityNumber,
      this.ImgPhotoFromApi,
      this.IdentityImgFromApi,
      this.AbsherImgFromApi,
      this.Role);
}


class info {
  final String Mobile;
  final String FullName;
  final String AbsuerNumber;
  final String Email;
  final String IdentityImg;
  final String AbsherImg;
  final String UserPhohot;
  final String City;
  final String IdentityNumber;
  final String ImgPhotoFromApi;
  final  String IdentityImgFromApi;
  final String AbsherImgFromApi;
  final String Role;
  info({
    this.Mobile,
    this.FullName,
    this.AbsuerNumber,
    this.Email,
    this.IdentityImg,
    this.AbsherImg,
    this.UserPhohot,
    this.City,
    this.IdentityNumber,
    this.ImgPhotoFromApi,
    this.IdentityImgFromApi,
    this.AbsherImgFromApi,
    this.Role});
  factory info.fromJson(Map<String, dynamic> json) {
    return info(
      Mobile: json['Mobile'],
      FullName: json['FullName'],
      AbsuerNumber: json['AbsuerNumber'],
      Email: json['Email'],
      IdentityImg: json['IdentityImg'],
      AbsherImg: json['AbsherImg'],
      UserPhohot: json['UserPhohot'],
      City: json['City'],
      IdentityNumber: json['IdentityNumber'],
      ImgPhotoFromApi: json['ImgPhotoFromApi'],
      IdentityImgFromApi: json['IdentityImgFromApi'],
      AbsherImgFromApi: json['AbsherImgFromApi'],
      Role: json['Role'],
    );
  }
}
class ProfileModle {
  int finishedDocument;
  int cancledDocument;
  int inProgressDocument;
  List<UserSS>  info;

  ProfileModle(this.finishedDocument, this.cancledDocument, this.inProgressDocument,
      this.info, this.address);

  List address;
}


