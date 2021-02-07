import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zanad_app/config/server_addersses.dart';
import '../themes/colors.dart';
import 'dart:async';
import '../themes/function.dart';
import 'package:location/location.dart';
class mapsHome extends StatefulWidget {
  @override
  _mapsHomeState createState() => _mapsHomeState();
}

class _mapsHomeState extends State<mapsHome> {
  Future<void> checkLocationServicesInDevice() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = new Location();

    _serviceEnabled = await location.serviceEnabled();

    if(_serviceEnabled)
    {

      _permissionGranted = await location.hasPermission();

      if(_permissionGranted == PermissionStatus.granted)
      {

        // _location = await location.getLocation();

        // print(_location.latitude.toString() + " " + _location.longitude.toString());


        location.onLocationChanged.listen((LocationData currentLocation) {



        });
      }else{

        _permissionGranted = await location.requestPermission();
        if(_permissionGranted == PermissionStatus.granted)
        {
          print('user allowed');
        }else{
          //   SystemNavigator.pop();
        }

      }

    }else{

      _serviceEnabled = await location.requestService();

      if(_serviceEnabled)
      {
        _permissionGranted = await location.hasPermission();

        if(_permissionGranted == PermissionStatus.granted)
        {

          print('user allowed before');

        }else{
          _permissionGranted = await location.requestPermission();
          if(_permissionGranted == PermissionStatus.granted)
          {
            print('user allowed');
          }else{
            //   SystemNavigator.pop();
          }}
      }else{

        //  SystemNavigator.pop();

      }

    }

  }
  List<Marker> markers ;
  @override
  void initState() {
    checkLocationServicesInDevice();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    ServerAddresses serverAddresses=new ServerAddresses();
    return Container(
      child: FutureBuilder<dynamic>(
        future: serverAddresses.connectData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            markers = [
              Marker(
                  markerId: MarkerId('first place'),
                  infoWindow: InfoWindow(
                      title: 'this place is so nice'
                  ),
                  position: LatLng(double.parse(snapshot.data['lat']),double.parse(snapshot.data['Long']))
              ),

            ];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              child: Material(
                  elevation: 4,
                  borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
                  child: Container(
                    //  margin: EdgeInsets.only(top: 16),
                      height:  MediaQuery.of(context).size.height*0.58,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          title(),
                          Container(//double.infinity
                            margin: EdgeInsets.only(top: 16),
                            height: MediaQuery.of(context).size.height*0.5,
                            width: MediaQuery.of(context).size.width*0.95 ,
                            child:  GoogleMap(
                              myLocationButtonEnabled: true,
                              markers:markers.toSet(),
                               myLocationEnabled: true,
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: true,
                              onMapCreated: onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target:  LatLng(24.774265, 46.738586),
                                zoom: 5.0,
                              ) ,
                            ),)
                        ],
                      ))),
            );

          }
          else if (snapshot.hasError) {
            return Text("تأكد من إتصال الإنترنت");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());},
      ),
    );


  }

  void onMapCreated(controller) {
    setState(() {
     // mapController = controller;
    });}
  Widget title(){
    return RichText(
      text: TextSpan(
          text: "خريطة ",
          style:TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler') ,
          children: <TextSpan>[
            TextSpan(text:"المكاتب",style: TextStyle(color: Colors.black,fontFamily: 'Schyler')),
          ]),);
  }
}
