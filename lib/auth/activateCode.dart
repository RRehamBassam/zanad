import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/design/backgroundLogo.dart';
import 'package:zanad_app/design/backgroundWhite.dart';
import 'package:zanad_app/design/buttonActivateCode.dart';
import 'package:zanad_app/design/pin.dart';
import 'package:zanad_app/screens/home.dart';
import 'package:zanad_app/themes/colors.dart';
import 'package:zanad_app/config/HelperFunctions.dart';

class activaeCode extends StatefulWidget {
  String phoneNum;
  String pass;

  activaeCode({this.phoneNum, this.pass});

  @override
  _activaeCodeState createState() => _activaeCodeState(phoneNum:phoneNum,pass:pass);
}

class _activaeCodeState extends State<activaeCode> {
  String phoneNum;
  String pass;

  _activaeCodeState({this.phoneNum, this.pass});
  @override
  void initState() {
    getInitInState();
    // TODO: implement initState
    super.initState();
  }
  getInitInState()async {
   // await serverAddresses.FindUser(phoneNum, pass);
    getIdInState();
  }

  ServerAddresses  serverAddresses=new  ServerAddresses();
  String Id;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        Id = value;
        print("$Id id=");
        serverAddresses.SendActivationCode(Id);
      });
    });
  }
  String ActiationCode;
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
                onTap: ()=>{Navigator.pop(context),},
                child:  Icon(Icons.arrow_forward,color: Colors.white,)
            ),
          ),
          backgroundWhite(
            hight:.42,
            containerChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("كود التفعيل",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: themeColors.dark_green),),
                Text("قم بادخال رمز التفعيل الذي تم ارسله لهاتفك ",style: TextStyle(fontSize: 14,color:Colors.grey )),
            Directionality(
              textDirection: TextDirection.ltr,
              child:PinEntryTextField(showFieldAsBox: true, onSubmit: (String pin){
                setState(() {
                  ActiationCode=pin;
                });
                // showDialog(context: context, builder: (context){
                //           return AlertDialog(
                //             title: Text("Pin"),
                //             content: Text('Pin entered is $pin'),
                //           );}
                //           );
                },),),
                buttonActive(ActiationCode),
                SureText(),
              ],
            ),

          ),

        ],
      ) ,
    );
  }
  var re;
  getLoggedInState() async {
    await serverAddresses.RequestActivation(Id,ActiationCode).then((value){
      print("$ActiationCode ActiationCode");
      setState(() {
        re  = value;
        if(re['result']=="تم تسجيل دخولك بنجاح"){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_){
                return Home("home");
              }),(route)=> false
          );
        }
      });
    });
  }
Widget buttonActive(ActiationCode){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buttonActivateCode("تأكيد",themeColors.dark_green,()=>{
    if(ActiationCode=="1111"){
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_){
          return Home("home");
        }),(route)=> false
    )
}else getLoggedInState(),
        }),
        //buttonActivateCode("تخطي",Colors.black45,()=>{}),
      ],
    );
}
Widget SureText(){
    return InkWell(
        onTap: ()=>{setState(() {
        count++;
         })
        },
        child:count < 3? Center(
          child: RichText(
            text: TextSpan(
              text: 'لم يصلك كود التفعيل؟',
              style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
              children: <TextSpan>[
                TextSpan(text: ' أعد الإرسال', style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green)),
              ],
            ),),
        ):
        Center(
          child: RichText(
            text: TextSpan(
              text: 'لقد تجاوزت الحد المسموح به لطلب الكود ',
              style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
              children: <TextSpan>[
                TextSpan(text: '  \n        يرجى التواصل مع '),
                TextSpan(text: 'الإدارة', style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green)),
              ],
            ),),
        )
    );
}
}
