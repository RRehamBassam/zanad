import 'package:flutter/material.dart';
class yesNoButton extends StatefulWidget {
  bool selectTrue;
  Function(bool) callback;


  yesNoButton({this.selectTrue,this.callback});

  @override
  _yesNoButtonState createState() => _yesNoButtonState(selectTrue,callback);
}

class _yesNoButtonState extends State<yesNoButton> {
  bool selectTrue;
  Function(bool) callback;
  _yesNoButtonState(this.selectTrue,this.callback);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: MediaQuery.of(context).size.width*0.4,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap:()=>{setState(()=>{
              selectTrue=true,
              callback(true)
            })},
            child: Container(

              width: MediaQuery.of(context).size.width*.194,
              padding:EdgeInsets.all(8) ,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey[200]),

                borderRadius: BorderRadius.only(topRight: Radius.circular(6.0),bottomRight: Radius.circular(6.0)),
                color:selectTrue?Colors.grey[200]:Colors.white ,
              ),
              child: Center(child: Text("نعم")),
            ),
          ),
          InkWell(
              onTap:()=>{setState(()=>{
                selectTrue=false,
                callback(false)
              })}
              ,child:Container(

            width: MediaQuery.of(context).size.width*.2,
            padding:EdgeInsets.all(8) ,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey[200]),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
              color:selectTrue?Colors.white:Colors.grey[200] ,
            ),
            child: Center(child: Text("لا")),
          )),
        ],
      ),
    );
  }
}
