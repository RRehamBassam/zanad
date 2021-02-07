import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:zanad_app/components/yesNoButtonAbsher.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
import 'package:zanad_app/design/backgroundLogo.dart';
import 'package:zanad_app/design/backgroundWhite.dart';
import 'package:zanad_app/items/singleAttachment.dart';
import '../themes/colors.dart';
import 'package:zanad_app/screens/home.dart';
class doneRep extends StatefulWidget {
  int id;
  int IdIsReceived;
  doneRep(this.id,this.IdIsReceived);

  @override
  _doneRepState createState() => _doneRepState(id,IdIsReceived);
}

class _doneRepState extends State<doneRep> {
  int id;
  bool selectTrue;
int IdIsReceived;
  _doneRepState(this.id,this.IdIsReceived);

  bool checkBoxValue;
  var userId;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
      });
    });
  }
  @override
  void initState() {
    getIdInState();
    // TODO: implement initState
    selectTrue=true;
    checkBoxValue=false;
    super.initState();
  }
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
            hight:.5,
            containerChild: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child:  Text("قم بإضافة صور مرفقات العميل ",style: TextStyle(fontSize: 14,color: Colors.black),),
                ),

                SizedBox(height: 25,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
               //  crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Attachment("صورة هوية",(val){}),
                   Attachment("مستند استلام وثيقة",(val){}),
                 ],
               ),
                SizedBox(height: 25,),
                Container(
                  height: 1,
                  margin: EdgeInsets.only(bottom: 5),
                  color: Colors.grey[300],
                ),
                Row(children: <Widget>[
                  Checkbox(
                    // title: Text('تم االتسليم',style: TextStyle(color: Colors.black)),
                      value: checkBoxValue,
                      activeColor: themeColors.dark_green,
                      onChanged:(bool newValue){
                        setState(() {
                          checkBoxValue = newValue;
                        });
                      }),
                  Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(' تم االتسليم المبلغ المعاملة كاملاً',style: TextStyle(color: Colors.black))),
                ],),

               Column(
                  children: <Widget>[
                    Column(children: <Widget>[


                    ],),
                    Container(
                      height: 1,

                    )
                  ],
                ),


                Button(userId,id,checkBoxValue),
              ],
            ),
          ),

        ],
      ) ,
    );
  }
  Widget Button(userId,id,checkBoxValue){
    ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
    return   InkWell(

      onTap:(){
        serverAddressesRequests.DeliverdRequest(userId,id,IdIsReceived,checkBoxValue,"NoReasonToReturn",true);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_){
              return Home("home");
            }),(route)=> false
        );
        //serverAddressesRequests.DeliverdRequest(userId,id,checkBoxValue,"");
       // Navigator.popAndPushNamed(context, '/activateCode');
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("تم التوصيل",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
