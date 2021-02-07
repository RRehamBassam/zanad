import 'package:flutter/material.dart';

class Characteristics {

  static BoxDecoration boxDecoration= BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    );
  static BoxDecoration boxDecorationgreen= BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
  color:Color(0xFF007A43) ,
  );
  static UnderlineInputBorder underlineInputBorder=UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[300]),
  );

  // static AppBar appBar=  AppBar(
  //     title:Text("زنـاد",style: TextStyle(fontSize: 18),) ,
  //     automaticallyImplyLeading: false,
  //     centerTitle: true,
  //     actions: <Widget>[
  //       InkWell(onTap: ()=>{Navigator.pop(context)},
  //           child: Container(
  //               margin: EdgeInsets.all(16),
  //               child: Icon(Icons.arrow_forward,color: Colors.white,))
  //       )],);


}