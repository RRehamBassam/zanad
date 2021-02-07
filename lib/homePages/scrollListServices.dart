import 'package:flutter/material.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/items/singleServices.dart';
class scrollListServices extends StatefulWidget {
  var Services;
Function(int) calback;
  scrollListServices(this.Services,this.calback);

  @override
  _scrollListServicesState createState() => _scrollListServicesState(Services,calback);
}

class _scrollListServicesState extends State<scrollListServices> {
  var Services;
  Function(int) calback;
  _scrollListServicesState(this.Services,this.calback);
  @override
  Widget build(BuildContext context) {
    ServerAddresses serverAddresses=new ServerAddresses();
    return Container(
      height: 140,
      child:FutureBuilder<dynamic>(
        future: serverAddresses.Services(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      calback(snapshot.data.length);
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder:(BuildContext ctxt, int index) {
            return  singleServices(Name:snapshot.data[index]['Name'],pic:snapshot.data[index]['pic'],id:snapshot.data[index]['id']);});
      }
      else if (snapshot.hasError) {
      return Text("${snapshot.error}");
      }
      // By default, show a loading spinner.
      return Center(child: CircularProgressIndicator());
    },
      )
      );
  }
}
