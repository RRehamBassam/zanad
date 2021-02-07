import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zanad_app/config/server_addersses.dart';

import '../themes/colors.dart';
import 'package:geolocator/geolocator.dart';
class contactPage extends StatefulWidget {
  @override
  _contactPageState createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  GoogleMapController mapController;
  static LatLng _initialPosition;
  List<Marker> markers ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          headerPage()
        ],
      ),
    );
  }
  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });}
  Widget headerPage(){
    ServerAddresses serverAddresses=new ServerAddresses();
    return Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
          height: MediaQuery.of(context).size.height* 0.85,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(

          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
            child:    FutureBuilder<dynamic>(
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
              return Column(
                children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'بيانات',
                    style:  TextStyle(fontWeight: FontWeight.bold,color: themeColors.dark_green,fontSize: 16,fontFamily: 'Schyler',),
                    children: <TextSpan>[
                      TextSpan(text: ' التواصل', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Schyler', )),
                    ],
                  ),),
                SizedBox(height: 8,),
                Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: double.infinity,
                  child: GoogleMap(

                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers:markers.toSet(),
                    onMapCreated: onMapCreated,
                   initialCameraPosition: CameraPosition(
                     target:  LatLng(24.774265, 46.738586),
                     zoom: 5.0,
                   ) ,
                  ),
                ),
                SizedBox(height: 16,),

                address("العنوان","جدة"),
                drackLine(),
                address("الإيميل","Musab@gmail.com"),
                drackLine(),
                address(" الفاكس","${snapshot.data['fax']}"),//"98 854754"
                drackLine(),
                address("رقم الهاتف","${snapshot.data['telephone']}"),//"98 854754"

                // drackLine(),
                // address("رقم الجوال","98 854754"),

              ],
            );   }
              else if (snapshot.hasError) {
                return Text("تأكد من إتصال الإنترنت");
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
              },
                      )
        ));}
            Widget lightLine(){
    return Container(
      height: 0.25,
      color: Colors.grey.withOpacity(0.4),
      margin: EdgeInsets.symmetric(vertical:10),);
            }
Widget drackLine(){
    return Container(
      height: 0.7,
      color: Colors.grey.withOpacity(0.4),
      margin: EdgeInsets.symmetric(vertical:12),);
}
    Widget address(String addTitle,String add){
    return    Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.15,
            child: Text(addTitle,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: 12),)),
        SizedBox(width: 40,),
        Text(add,style: TextStyle(color: Colors.black,fontSize: 13,letterSpacing: 3),textDirection: TextDirection.ltr,),
      ],
    );
    }

}
