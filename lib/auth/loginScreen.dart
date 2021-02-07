import 'dart:convert';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';
import 'package:zanad_app/auth/a.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/networks/databaseMethods.dart';
import 'package:zanad_app/themes/characteristics.dart';
import 'package:zanad_app/themes/colors.dart';
import 'ex.dart';
import 'auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> _authData = {'email': '+966561231234', 'password': '123456'};
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  String phoneNumber;
  String phoneIsoCode;
  var resultSignUp;
  var numberchek;
  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      numberchek=number;
      print("n=$phoneNumber p=$phoneIsoCode i=$internationalizedPhoneNumber");
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  String changeName;
  String changePass;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,

      body: SingleChildScrollView(

        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Image.asset('assets/logo.png',height: 100,),
            SizedBox(height: 10,),
            Text("تسجيل مستخدم جديد",style: TextStyle(color: themeColors.dark_green,fontSize: 20)),
            container(),
            SizedBox(height: 8,),
           // re!=null?Text(re,style: TextStyle(color: themeColors.dark_green,fontSize: 12)):Container(),
            resultSignUp!=null?Text(resultSignUp,style: TextStyle(color:resultSignUp== "تم تسجيل حسابك بنجاح"?themeColors.dark_green:Colors.red,fontSize: 12)):Container(),
            button(phoneNumber,changePass),
            endText(),

          ],
        ),
      ),
    );
  }
  bool _obscureText=true;
   Widget container(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: <Widget>[
          MediaQuery.of(context).size.height> 743.4285714285714? SizedBox(height: 30,):Container(),
          Container(
            margin: EdgeInsets.only(right: 30,top: 8) ,
            alignment: Alignment.centerRight,
            child: Text(" اسم ثلاثي",style: TextStyle(color: Color(0xFF007A43))),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 4) ,
            child: TextField(
              onChanged:(vall)=>setState(()=>changeName=vall),
              controller: _nameController,
              keyboardType:TextInputType.visiblePassword,
              decoration: InputDecoration(
                enabledBorder:Characteristics.underlineInputBorder,
                disabledBorder: Characteristics.underlineInputBorder,
                border: Characteristics.underlineInputBorder,
                labelStyle: new TextStyle(
                  color: Colors.grey[200],
                ),
                  hintText: "اكتب اسم ثلاثي",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 4) ,
            alignment: Alignment.centerRight,
            child:Text("رقم الموبايل",style: TextStyle(color: Color(0xFF007A43))),),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 4) ,
              child: Column(children: <Widget>[
                 Directionality(
                   textDirection: TextDirection.ltr,
                     child: InternationalPhoneInput(
                       errorStyle: TextStyle(color: Colors.red),
                         errorText:"Enter a correct number",
                     // hintStyle: TextStyle(color: Colors.white),
                       decoration:InputDecoration.collapsed(hintText: '(56) 123-1234'),
                         onPhoneNumberChange: onPhoneNumberChange,
                         initialPhoneNumber: phoneNumber,
                         initialSelection:phoneIsoCode,
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
                   ],),),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30,vertical: 4) ,
                    alignment: Alignment.centerRight,
                    child: Text("كلمة المرور",style: TextStyle(color: Color(0xFF007A43)))),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),

                child:
                 TextFormField(
                  keyboardType:TextInputType.visiblePassword,
                  autofocus: false,
                  obscureText: _obscureText,
                  validator: (String value){
                   if(value.length > 10){
                   return 'أدخل كلمة مرور اقق من 9 أ{قام أو رموز';
                   }
                   },
                   maxLength: 9,

                   onChanged:(vall)=>setState(()=>changePass=vall),
                controller: _passwordController,
                  decoration: InputDecoration(
     icon: InkWell(
       onTap: (){
         setState(() {
           _obscureText=!_obscureText;
         });
       },
       child:_obscureText? const Padding(
       padding: const EdgeInsets.only(top: 15.0),
       child:const Icon(Icons.lock_outline) ,
     ):const Icon(Icons.lock_open)),
                    enabledBorder: Characteristics.underlineInputBorder,
                    disabledBorder: Characteristics.underlineInputBorder,
                    border: Characteristics.underlineInputBorder,
                    labelStyle: new TextStyle(
                      color: Colors.grey[200],
                    ),

                      hintText: "**************",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                     // border: InputBorder.none
                  ),
                ),
              ),


            ],
          ),
        );

   }
  var authInfo;
  String re;
  var signReturn;
  getLoggedInState(phoneNum, pass) async {
    await HelperFunctions.getUserEmailSharedPreference().then((value){
      setState(() {
        re  = value;
      });
      if(value =="تم تسجيل حسابك بنجاح"){
        getFindInState( phoneNum, pass);
        Navigator.pushNamed(context, '/enterNoAbsher');
      }
    });
  }

  ServerAddresses  serverAddresses=new  ServerAddresses();
  getLoggedsignupState() async {
    await serverAddresses.signUp(changeName,phoneNumber,changePass).then((value){
      setState(() {
        print("$resultSignUp  resultSignUp");
        resultSignUp  = value;
      });

    });
  }
var  rFindUser;
  getFindInState(String phoneNum,String pass) async {
    await serverAddresses.FindUser(phoneNum,"$pass").then((value){
      setState(() {
        rFindUser  = value;
        if (rFindUser is String) {
          setState(() {
            resultSignUp="خطأ في اسم المستخدم أو كلمة المرور.";
          });
        }
      });
    });
  }

  Widget button(String phoneNum,String pass){
     final DatabaseMethods _db = DatabaseMethods();
     ServerAddresses  serverAddresses=new  ServerAddresses();
     Future<Map<String, dynamic>> result;

    return InkWell(
      onTap:()async{ print(numberchek);
        if(phoneNum== null || phoneNum.length < 9){

          setState(() {
            resultSignUp="يجب عليك ادخل رقم الموبايل صحيح ";
          });
        }else if(pass.length < 6){
          resultSignUp="يجب عليك ادخل كلمة مرور 6 ارقام أو رموز";

        }
        else {
        await  getLoggedsignupState();
       // await serverAddresses.signUp(changeName,phoneNumber,changePass);
        getLoggedInState(phoneNum, pass);
        print("re= nnn$re");
        print(phoneNumber);
       // serverAddresses.Profile();
        print("re=$_passwordController");
       // print( serverAddresses.signUp(_nameController.text,"+96655455555",_passwordController.text));
       if(re =="تم تسجيل حسابك بنجاح"){
         HelperFunctions.saveUserNameSharedPreference(_nameController.text);
       Navigator.pushNamed(context, '/enterNoAbsher');}else{
      //  print(serverAddresses.signUp(_nameController.text,phoneNumber,_passwordController.text));
       }}
       } ,
      child: Container(
        decoration: Characteristics.boxDecorationgreen,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("تسجيل مستخدم",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
   }
  Widget endText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text( ' لديك حساب مسجل؟',style:TextStyle(color: Colors.grey,fontFamily: 'Schyler')),
        InkWell( onTap:(){Navigator.popAndPushNamed(context, '/register');} ,
            child: Text( ' سجل معنا', style: TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler'))),
      ],);
  }
}
