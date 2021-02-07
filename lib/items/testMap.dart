import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/payment.dart';
import 'dart:async';
import '../themes/function.dart';
import 'package:location/location.dart';

class MapTest extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapTest> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  LatLng _lastMapPosition = _center;
  List<Marker> markers ;
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
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
            print(currentLocation.latitude.toString() + " yess" + currentLocation.longitude.toString());

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
    mapController = controller;
    _controller.complete(controller);

    LatLng latLng_1 = LatLng(40.416775, -3.70379);
    LatLng latLng_2 = LatLng(41.385064, 2.173403);
    LatLngBounds bound = LatLngBounds(southwest: latLng_1, northeast: latLng_2);

    setState(() {
      _markers.clear();
      addMarker(latLng_1, "Madrid", "5 Star Rating");
      addMarker(latLng_2, "Barcelona", "7 Star Rating");
    });

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    this.mapController.animateCamera(u2).then((void v){
      check(u2,this.mapController);
    });

  }

  void addMarker(LatLng mLatLng, String mTitle, String mDescription){
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId((mTitle + "_" + _markers.length.toString()).toString()),
      position: mLatLng,
      infoWindow: InfoWindow(
        title: mTitle,
        snippet: mDescription,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1=await c.getVisibleRegion();
    LatLngBounds l2=await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90)
      check(u, c);
  }


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: GoogleMap(
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 20.0,
          ),
          onCameraMove: _onCameraMove,
        ),
      )
    ;
  }
}