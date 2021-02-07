import 'package:http/http.dart' as http;
import 'package:zanad_app/Request/maps.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'dart:convert' as convert;
import 'dart:io';
class ServerAddressesRequests {
  static const serverAddress = 'https://zenadapp.com/ZenadApi/';
  Future<dynamic> oneRequests(String Id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Requests/${Id}';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();

    String reply = await response.transform(convert.utf8.decoder).join();
    print(response.statusCode);
    print(reply);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    //HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;

  }
  Future<void> UpdateRequest(int RequestId, var PaymentMethodId, String UserId,String note,String City,String attachment) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/UpdateRequest';
    Map map={
      "RequestId":RequestId,
      "ChoosedLocationsId": 2,
      "PaymentMethodId": 3,
      "UserId": UserId,
      "note": note,
      "address": City,
      "timeFrom": "00:00:00.1234567",
      "timeTo": "00:00:00.1234567",
      "attachment": attachment,
      "isNewServiceName": true,
      "NewServiceName": "sample string 11"
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    print(response.statusCode);

  }
  //https://api.zenadapp.com/api/DelegateRequest?userId=bc58fc06-51f0-40c1-8529-2dd4a74b40e8
  Future<dynamic> DelegateRequest(String UserId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/DelegateRequest?userId=${UserId}';//bc58fc06-51f0-40c1-8529-2dd4a74b40e8

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
   // HelperFunctions.saveUserEmailSharedPreference(itemCount);
    return itemCount;

  }
  Future<void> cancelRequest(int RequestId,String UserId,String Note) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/cancelRequest';
    Map map={
      "RequestId": RequestId,
      "UserId": UserId,
      "Note": "sample string 3"
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    print(response.statusCode);

  }

  Future<dynamic> AllRequest(String userId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/AllRequest?userId=${userId}';

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
   // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    dynamic itemCount = jsonResponse;
    if (itemCount is Map) {
      return [];
    }
    print(itemCount);
    return itemCount;

  }
  Future<dynamic> Requests(int userId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Requests/${userId}';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yessssss");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;

  }
  Future<dynamic> DeliverdRequest(String userId,int RequestId,int DelegatRequestId,bool DonePayment,String ReasonToReturn,bool IsDeleiverd) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/DeliverdRequest';
    Map map={
      "UserId": "$userId",
      "RequestId": RequestId,
      "DelegatRequestId": DelegatRequestId,
      "IdentityPhoto": "",
      "FilesPhoto": "",
      "DonePayment": DonePayment,
      "paymentTypeId":4,
      "IsDeleiverd": IsDeleiverd,
      "ReasonToReturn": "$ReasonToReturn",
      "SignImg": ""
    };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
     request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yessssssDeliverdRequest");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;

  }
  Future<dynamic> RequestsAll() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/Requests';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yessssss");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print("RequestsAll");
    print(itemCount);
    return itemCount;

  }
  Future<dynamic> IsRecevid(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='${serverAddress}api/IsRecevid?id=${id}';

    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(convert.utf8.encode(convert.json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(convert.utf8.decoder).join();
    print("yes");
    print(reply);
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(reply);
    var itemCount = jsonResponse;
    print("IsRecevid");
    print(itemCount);
    return itemCount;

  }
}