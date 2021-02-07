
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/networks/databaseMethods.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
import '../auth/activateCode.dart';
class registerScreen extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<registerScreen> {
  var resultSignUp;
  String phoneNumber;
  String phoneIsoCode;
  String changePass;
  TextEditingController _passController = new TextEditingController();

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }
  bool textErere;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool textErere;
print("${MediaQuery.of(context).size.height}  height");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Image.asset('assets/logo.png',height: 100,),
            SizedBox(height: 10,),
            Text("سجل دخولك برقم موبايلك",style: TextStyle(color: Color(0xFF007A43),fontSize: 20)),
            container(),
            resultSignUp!=null?Text(resultSignUp,style: TextStyle(color: themeColors.dark_green,fontSize: 12)):Container(),
            textErere!=null?textErere?Container(): Text("رقم الجوال او كلمة المرور غير صحيحة",style:TextStyle(color: Colors.red)):Container(),
            Button(phoneNumber,changePass),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( ' ليس لديك حساب؟',style:TextStyle(color: Colors.grey,fontFamily: 'Schyler')),
                InkWell( onTap:(){Navigator.popAndPushNamed(context, '/login');} ,
                    child: Text( ' سجل معنا', style: TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler'))),
              ],),
          ],
        ),
      ),
    );
  }
  bool _obscureText = true;
  Widget container(){

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding:EdgeInsets.symmetric(vertical: 35) ,
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MediaQuery.of(context).size.height> 743.4285714285714? SizedBox(height: 40,):Container(),
            Container(
           //  margin: EdgeInsets.symmetric(vertical: 25) ,
              alignment: Alignment.centerRight,
              child:Text("رقم الموبايل",style: TextStyle(color: Color(0xFF007A43))),),
            Column(children: <Widget>[
              Directionality(
                textDirection: TextDirection.ltr,
                child: InternationalPhoneInput(
                  // hintStyle: TextStyle(color: Colors.white),
                    decoration:InputDecoration.collapsed(hintText: '(56) 123-1234',),
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
            ],),


        Container(
            alignment: Alignment.centerRight,
            child: Text("كلمة المرور",style: TextStyle(color: Color(0xFF007A43)))),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: 25,vertical: 4) ,
            child: TextField(
              autofocus: false,
              obscureText: _obscureText,
              maxLength: 9,
              keyboardType:TextInputType.visiblePassword,
              controller:_passController ,
              onChanged:(vall)=>setState(()=>changePass=vall),
              decoration: InputDecoration(
                icon: InkWell(
                  onTap: (){
                   setState(() {
                     _obscureText=!_obscureText;
                   });
                  },
                  child: _obscureText? const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child:const Icon(Icons.lock_outline) ,
                  ):const Icon(Icons.lock_open),
                ),
              enabledBorder: Characteristics.underlineInputBorder,
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
                border: Characteristics.underlineInputBorder,
              labelStyle: new TextStyle(
                color: Colors.grey[200],
              ),
            hintText: "**************",
            hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
            ),)),
          ],
        ),
      ),
    );
  }

  Widget Button(String phoneNum, pass){
    String re;
    var rFindUser;
    final DatabaseMethods _db = DatabaseMethods();
    ServerAddresses  serverAddresses=new  ServerAddresses();
    getLoggedInState() async {
      await serverAddresses.signIn(phoneNum,"$pass").then((value){
        setState(() {
          re  = value;
        });
      });
    }
    getFindInState() async {
      if(phoneNum== null|| pass.length < 6){
        setState(() {
          resultSignUp="خطأ في اسم المستخدم أو كلمة المرور.";
        });
      }

      await serverAddresses.FindUser(phoneNum,"$pass").then((value){
        setState(() {
          rFindUser  = value;
          if (rFindUser is String) {
            setState(() {
              resultSignUp="خطأ في اسم المستخدم أو كلمة المرور.";
            });
          }
          if(rFindUser['Message']=="تم تسجيل الدخول" && textErere!=true){
            textErere=true;
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>activaeCode(phoneNum:phoneNum,pass: pass)));
          }else{
            setState(() {
              textErere=false;
            });
          };
        });
      });
    }

 var dataUser ;
    return   InkWell(
      onTap:()async{
        print("$pass  passs");
        await getLoggedInState();
        print("$re  re");
        if(re=="تم تسجيل دخولك بنجاح"){
          print("yes");
          getFindInState();
         // HelperFunctions.saveUserIdSharedPreference(dataUser['UserId']);
          //print(dataUser['UserId']);

        //  Navigator.pushNamed(context, '/activateCode');
        }else{

        }
       // serverAddresses.Profile();
       // _db.signIn(phoneNum,pass);

      } ,
      child: Container(
        decoration: Characteristics.boxDecorationgreen,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("تسجيل الدخول",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
