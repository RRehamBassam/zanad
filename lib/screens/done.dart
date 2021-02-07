import 'package:zanad_app/design/backgroundLogo.dart';
import 'package:zanad_app/design/backgroundWhite.dart';
import 'package:zanad_app/themes/colors.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
class done extends StatefulWidget {
  @override
  _doneState createState() => _doneState();
}

class _doneState extends State<done> {

  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

      body:Stack(
        children: <Widget>[
         backgroundLogo(),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 16),
            child: InkWell(
                onTap: ()=>{Navigator.pop(context)},
                child:  Icon(Icons.arrow_forward,color: Colors.white,)
            ),
          ),
          backgroundWhite(
            hight:0.35,
            containerChild: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("تم اتمام العملية بنجاح",style: TextStyle(fontSize: 20,),),
                Text("سيتم المتابعة من طرفنا لإنجاز معاملتك سريعاًً ",style: TextStyle(fontSize: 14,color:Colors.grey )),
                 SizedBox(height: 20,),
                Button(),
              ],
            ),
          ),

        ],
      ) ,
    );
  }
  Widget Button(){
    return   InkWell(
      onTap:(){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_){
              return Home("home");
            }),(route)=> false
        );
      //  Navigator.popAndPushNamed(context, '/home');
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 14,top: 10),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("عودة لصفحة الرئيسية",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

}
