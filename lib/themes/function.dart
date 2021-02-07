import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class fun{
Future<dynamic> getPlace( latitude, longitude) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(52.2165157, 6.9437819);
 // List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(_position.latitude, _position.longitude);

  // this is all you need
  Placemark placeMark  = newPlace[0];
  String name = placeMark.name;
  String subLocality = placeMark.subLocality;
  String locality = placeMark.locality;
  String administrativeArea = placeMark.administrativeArea;
  String postalCode = placeMark.postalCode;
  String country = placeMark.country;
  String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

  print(address);
return address ;
  // setState(() {
  //   _address = address; // update _address
  // });
}}