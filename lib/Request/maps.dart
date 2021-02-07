

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zanad_app/models/req.dart';
import '../screens/payment.dart';
import 'dart:async';
import '../themes/function.dart';
import 'package:location/location.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:geocoder/geocoder.dart';
class maps extends StatefulWidget {
  Req req;

  maps(this.req);

  @override
  _mapsState createState() => _mapsState(req);
}

class _mapsState extends State<maps> {
  Req req;

  _mapsState(this.req);

  ServerAddresses serverAddresses=new ServerAddresses();
  Location location = new Location();
  var addresses;
  LatLng latLng;
  LatLng latLnglocation;
  String userId;
  String add1;
  String add2;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
        print(userId);

      });
    });
  }
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
   @override
  void initState() {
     getIdInState();
     markers=[];
    super.initState();

    checkLocationServicesInDevice();

  }
  Future<void> checkLocationServicesInDevice() async {

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
        //  print(currentLocation.latitude.toString() + " yess" + currentLocation.longitude.toString());
          latLnglocation=LatLng(currentLocation.latitude,currentLocation.longitude);
         // List<Placemark> placemarks =  placemarkFromCoordinates(52.2165157, 6.9437819);
         setState(() {
           markers = [
             Marker(
                 markerId: MarkerId('first place'),
                 infoWindow: InfoWindow(
                     title: 'this place is so nice'
                 ),
                 position: LatLng(currentLocation.latitude,currentLocation.longitude)
             ),
             Marker(
                 markerId: MarkerId('place 3'),
                 infoWindow: InfoWindow(
                     title: 'this place is so nice'
                 ),
                 position: LatLng(41.0240567,29.0840848)
             ),
           ];
         });


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
  String _address = ""; // create this variable


  List<Marker> markers ;

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

     final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

     final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    }
    _handel(LatLng tappedPoint)async {
      print(tappedPoint);
      final coordinates= new Coordinates(tappedPoint.latitude,tappedPoint.longitude);
       addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);



      setState(() {
        markers=[];
        print("${addresses.first.featureName} hhhh  ${addresses.first.addressLine}");
       add1 = addresses.first.featureName;
        add2= addresses.first.addressLine;
        latLng=tappedPoint;
        markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ));
      });
    }
    return Scaffold(
        body:Material(
      child:Stack(
        children: <Widget>[

          Container(
            child:  GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              markers:markers.toSet(),
              onMapCreated: onMapCreated,
                onTap: _handel,
              initialCameraPosition: CameraPosition(
                target: LatLng(22.774265, 46.738586),
                zoom: 4.0,
              ) ,
            ),
          ),
          Positioned(
            right: 30,
            left: 30,
            bottom: 40,
              child:
             Button()),
        ],
      )
    ));
  }
  void onMapCreated(controller) {
    setState(() {
      // mapController = controller;
    });}

  Widget Button(){

    return   InkWell(
      onTap:(){
        if(latLng==null){
          setState(() {
            latLng=latLnglocation;
          });
        }else{
        serverAddresses.addAddress(userId,"${latLng.longitude}","${latLng.latitude}");
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Payment(req,"$add1 / $add2")));}
        //Navigator.popAndPushNamed(context, '/activateCode');
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width*0.7,
        height: 45,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text(" الإعتماد",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
