import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/themes/characteristics.dart';
class backgroundWhite extends StatelessWidget {
  Widget containerChild;
  double hight;

  backgroundWhite({this.containerChild,this.hight});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)),
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height*hight,
          width: MediaQuery.of(context).size.width * 0.88,
          decoration: Characteristics.boxDecoration,
          child:containerChild ,
        ),
      ),
    );
  }
}
