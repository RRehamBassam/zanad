import 'package:flutter/material.dart';
import 'package:zanad_app/components/boxTrans.dart';
import 'package:zanad_app/drawerPages/CurrentTransactiosRep.dart';
import 'package:zanad_app/items/singleNotification.dart';
class profileRep extends StatefulWidget {
  @override
  _profileRepState createState() => _profileRepState();
}

class _profileRepState extends State<profileRep> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView(
        children: <Widget>[
          boxTrans(),
          SizedBox(height: 4,),
          notifictions(),
          SizedBox(height: 4,),
          CurrentTransactiosRep(true)
        ],
      ),
    );
  }
  Widget notifictions(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
    child: Material(
    elevation: 2,
    borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
    child: Container(
    height: MediaQuery.of(context).size.height* 0.2,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
      child: ListView(
        children: <Widget>[
        Text("الإشعارات",style: TextStyle(fontSize: 16),),
        //  singleNotification(),
          Container(height: 1,color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 4),)
      ],
      ),
    )));
  }

}
