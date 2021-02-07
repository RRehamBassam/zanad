import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:zanad_app/components/yesNoButtonAbsher.dart';
import 'package:zanad_app/design/backgroundLogo.dart';
import 'package:zanad_app/design/backgroundWhite.dart';
import '../themes/colors.dart';
import 'package:zanad_app/config/server_addersses.dart';
import '';
class enterNoAbsher extends StatefulWidget {
  @override
  _enterNoAbsherState createState() => _enterNoAbsherState();
}

class _enterNoAbsherState extends State<enterNoAbsher> {
  String phoneNumber;
  String phoneIsoCode;
  String Message;
  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }
  bool selectTrue;
  @override
  void initState() {
    // TODO: implement initState
    selectTrue=true;
    super.initState();
  }
  bool isAbshernum;
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
                Text("تم تسجيل حسابك بنجاح ",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("هل قمت بإدخال رقم الجوال المسجل في خدمة أبشر ",style: TextStyle(fontSize: 12,color:Colors.grey )),
                yesNoButton(selectTrue:selectTrue,callback: (val){setState(() {
                  isAbshernum=val;
                });},),
                Container(alignment: Alignment.centerRight,
                    child: Text("  أدخل رقم المسجل في خدمة أبشر",style: TextStyle(fontSize: 12,color: themeColors.dark_green),)),
              Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: InternationalPhoneInput(
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: phoneNumber,
                          initialSelection:phoneIsoCode,
                        // hintStyle: TextStyle(color: Colors.white),
                          decoration:InputDecoration.collapsed(hintText: '(56) 123-1234'),
                          dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.white.withOpacity(0),),
                          labelStyle: TextStyle(color: Colors.grey[300]),
                          enabledCountries: ['+966'],
                          //showCountryFlags: false,
                          showCountryCodes: true),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(bottom: 5),
                      color: Colors.grey[300],
                    )
                  ],),
                  Container(
                    height: 1,

                  )
                ],
              ),
                Text("سيتم إرسال كود التفعيل برسالة نصية الى هاتفك ",style: TextStyle(fontSize: 12,color:Colors.grey )),
                Message!=null?Text(Message,style: TextStyle(fontSize: 12,color:Colors.red )):Container(),
                Button(),
              ],
            ),
          ),

        ],
      ) ,
    );
  }
  Widget Button(){
    ServerAddresses  serverAddresses=new  ServerAddresses();
    return   InkWell(
      onTap:(){
        if(isAbshernum==false&&phoneNumber==null){
        setState(() {
          Message="يجب عليك إدخال رقم أبشر";
        });
        }else{
        serverAddresses.IsAbsherNumber(phoneNumber,isAbshernum);
       // serverAddresses.SendActivationCode("");
        Navigator.popAndPushNamed(context, '/activateCode');}
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
          child: Text("أرسل كود التفعيل",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
