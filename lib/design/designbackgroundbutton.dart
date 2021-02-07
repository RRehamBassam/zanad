import 'package:flutter/material.dart';
class backgroundButton extends StatelessWidget {

  String text;
  Color color;
  Function onTap;

  backgroundButton(this.text,this.color,this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.32,
        height: MediaQuery.of(context).size.height *0.049,
        padding: EdgeInsets.only(bottom: 5),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
         borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Center(child: Text(text ,style: TextStyle(color: Colors.white),)),
      ),
    );
  }


}
