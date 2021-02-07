import 'package:flutter/material.dart';
import 'package:zanad_app/themes/characteristics.dart';
class textFeild extends StatelessWidget {
  String hintText;
  Function(String) callback;
  String label;

  textFeild({this.hintText,this.callback,this.label});
  TextEditingController _Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  TextFormField(
      initialValue:label==null ?"":"$label",
  //  controller:_Controller ,
      onChanged: (val){
        callback(val);
      },
    //  keyboardType:TextInputType.visiblePassword,
      decoration: InputDecoration(

        enabledBorder: Characteristics.underlineInputBorder,
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),
        border:  Characteristics.underlineInputBorder,
        labelStyle: new TextStyle(
          color: Colors.grey[200],
        ),
        hintText:label==null? hintText:label,
        hintStyle: TextStyle(color: Colors.grey[350],fontSize: 14),
      ),
    );
  }
}
