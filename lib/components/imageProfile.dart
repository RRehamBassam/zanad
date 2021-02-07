import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
class imageProfile extends StatelessWidget {
  String Image;
  Uint8List bytes;

  imageProfile(this.Image, this.bytes);

  @override
  Widget build(BuildContext context) {
    return  Material(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        elevation: 4,
        child:  Container(
          alignment: Alignment.topCenter,
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/profile.png',)
              )),)

    );
  }
}
