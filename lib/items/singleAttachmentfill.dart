
import 'package:flutter/material.dart';

class Attachmentfill extends StatelessWidget {
  String documentName;

  Attachmentfill(this.documentName);

  @override
  Widget build(BuildContext context) {
    return  InkWell(

      child: Column(
        children: <Widget>[
      //SizedBox(height: 8,),
        Stack(
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(height: 5,),
              Row(children: <Widget>[SizedBox(width:5,),  Image.asset("assets/NewRequest.png",scale: 3.5,)],)

            ],)
         ,
         // Positioned(
         // top: 0,
         // right: 0,
         // child:add() ,),
    ], ),
          SizedBox(height: 5,),
          Text(documentName,style: TextStyle(fontSize: 12),),
          ///Image.asset("assets/photo-camera.png",width:20 ,height: 40.0,)
// SizedBox(height: 16,)
        ],
      ),

    );
  }
  Widget add(){
    return   Container(

      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 0.5,color: Colors.white),
          color: Colors.red),
      child: Icon(Icons.clear,color: Colors.white,size: 12,),
    );
  }
}

