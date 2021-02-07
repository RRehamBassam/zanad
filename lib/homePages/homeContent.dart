import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/auth/loginScreen.dart';
import 'package:zanad_app/auth/registerScreen.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/homePages/scrollListServices.dart';
import 'package:zanad_app/items/singleServices.dart';
import 'package:zanad_app/screens/servicesScreens.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../design/designbackgroundbutton.dart';
import 'QueryContainer.dart';
import '../themes/colors.dart';
import 'mapsHome.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';

class homeContent extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<homeContent> {
  String userName;
  String userMobile;
  var Services;
  int lenServices;
  ServerAddresses serverAddresses=new ServerAddresses();
  // getServicesInState() async {
  //   await serverAddresses.Services().then((value){
  //     setState(() {
  //       Services  = value;
  //       lenServices= Services.length;
  //     });
  //   });
  // }
  getLoggedInState() async {
    await HelperFunctions.getUserNameSharedPreference().then((value){
      setState(() {
        userName  = value;
      });
    });
  }
  String userImage;
  Uint8List bytes;
  getImageInState() async {
    await HelperFunctions.getUserImageSharedPreference().then((value){
      setState(() {
        userImage  = value;
        bytes = convert.base64.decode(userImage);
      });
    });
  }
  getmobileInState() async {
    await HelperFunctions.getUserMobileSharedPreference().then((value){
      setState(() {
        userMobile = value;
      });
    });
  }
  int lengthServices;
  @override
  void initState() {
   // getServicesInState();
    getLoggedInState();
    getmobileInState();
    getImageInState();
    lenServices=0;
    lengthServices=0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userName);
      return FutureBuilder<dynamic>(
          future: serverAddresses.Services(),
        builder: (context, snapshot) {
       if (snapshot.hasData) {return Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        child: Expanded(
          child: ListView(
            physics:BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
               bodyHome(),
              SizedBox(height: 3,),
              mostUsedServices(Services),
              SizedBox(height: 3,),
              Expanded(child: queryBox()),
              SizedBox(height: 3,),
              mapsHome(),
            ],
          ),
        ),
      ) ; }
        else if (snapshot.hasError) {
          return  Center(child: Text("تأكد من إتصال بالانترنت"));
        }
    // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
    },
      );
  }
   Widget bodyHome(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
          decoration:Characteristics.boxDecoration,
          height:userName==null && userMobile==null? 180:140,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(4),
          // color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  elevation: 4,
                  child:  userImage==null? Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:  AssetImage('assets/profile.png',)
                        )),):ClipOval(
        // radius: 45,
        child: Image.memory(bytes,fit: BoxFit.fitWidth,height: 50.0,width: 50.0,),
    )

              ),

              SizedBox(height: 8,),
              userName==null && userMobile==null?  RichText(
                text: TextSpan(
                  text: 'للاستفادة من التطبيق ',
                  style:  TextStyle(color: Colors.black,fontFamily: 'Schyler'),
                  children: <TextSpan>[
                    TextSpan(text: ' يرجى إنشاء حساب', style: TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler')),
                  ],
                ),):   RichText(
                text: TextSpan(
                  text: "اهلا بك ",
                  style:  TextStyle(color:themeColors.dark_green,fontFamily: 'Schyler',fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: "$userName", style: TextStyle(color:  Colors.black ,fontFamily: 'Schyler',fontWeight: FontWeight.normal)),
                  ],
                ),),

              Text("أنجز معاملاتك الحكومية وخدماتك بلمسة واحدة",style: TextStyle(fontSize: 10,color:Colors.grey ),),
              userName==null && userMobile==null? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  backgroundButton("تسجيل", themeColors.dark_green,register),
                  backgroundButton("دخول",Color(0xFF2B2B2B),login),
                ],
              ) :Container(),

            ],
          ),

        ),
      ),
    );
   }
   Widget mostUsedServices(Services){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration:Characteristics.boxDecoration,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: "الخدمات",
                        style:TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler') ,
                        children: <TextSpan>[
                          TextSpan(text:" الأكثر استخدامًا",style: TextStyle(color: Colors.black,fontFamily: 'Schyler')),
                        ]),),
                        scrollListServices(Services,(val){
                          lengthServices=val;}),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: ()=>{Navigator.push(context, new MaterialPageRoute(builder: (context)=>new servicesScreens()))},
                  child: Center(
                    child: Text("عرض كافة الخدمات(${lengthServices})", style: TextStyle(color: themeColors.dark_green)),
                  ),
                )
              ],
            )
        ),
      ),
    );
   }
  Function login(){
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>new registerScreen()));
   // Navigator.popAndPushNamed(context, '/register');
  }
  Function register(){
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>new LoginScreen()));
   // Navigator.popAndPushNamed(context, '/login');
  }
}