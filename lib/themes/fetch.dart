import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
Future<Album> fetchAlbum() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

  HttpClientRequest  request =
  await client.getUrl(Uri.parse('https://api.zenadapp.com/api/Account/UserInfo'));
  HttpClientResponse response = await request.close();

  String reply = await response.transform(utf8.decoder).join();

  print(reply);

  if (response.statusCode == 200) {
    print(response.statusCode);
    print("yes");

   return Album.fromJson(json.decode(reply));
  } else {
    throw Exception('Failed to load album');
  }
}
class Album {
  final String Email;
  final bool HasRegistered;
  final String LoginProvider;

  Album({this.Email, this.HasRegistered, this.LoginProvider});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      Email: json['Email'],
      HasRegistered: json['HasRegistered'],
      LoginProvider: json['LoginProvider'],
    );
  }
}
class MyApp2 extends StatefulWidget {
  MyApp2({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp2> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.Email);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
