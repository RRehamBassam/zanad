import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
class checkBox extends StatefulWidget {
  bool checkBoxValue;
  int id;
  checkBox(this.checkBoxValue,this.id);
  @override
  _checkBoxState createState() => _checkBoxState(checkBoxValue,id);
}

class _checkBoxState extends State<checkBox> {
  bool checkBoxValue;
  int id;
  _checkBoxState(this.checkBoxValue,this.id);

  @override
  Widget build(BuildContext context) {
    ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
    return Checkbox(
      // title: Text('تم االتسليم',style: TextStyle(color: Colors.black)),
        value: checkBoxValue,

        activeColor: themeColors.dark_green,
        onChanged:(bool newValue){
          setState(() {
            serverAddressesRequests.IsRecevid(id);
            if(!checkBoxValue){
           checkBoxValue = true;
            }
          });

          Text('تم التسليم',style: TextStyle(color: Colors.black),);
        });
  }
}
