import 'package:flutter/material.dart';
import '../themes/colors.dart';
class buttonActivateCode extends StatelessWidget {
  String title;
  Function onTap;

  buttonActivateCode(this.title, this.color,this.onTap);

  Color color;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        width: 120,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Center(
          child: Text(title,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
