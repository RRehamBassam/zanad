import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/drawerPages/contactPage.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
import 'package:zanad_app/drawerPages/notification.dart';
import 'package:zanad_app/drawerPages/profile.dart';
import 'package:zanad_app/drawerPages/aboutOffice.dart';
import 'package:zanad_app/not/not.dart';
import 'package:zanad_app/screens/requestnewTransaction.dart';
import 'package:zanad_app/screens/servicesScreens.dart';
import '../homePages/homeContent.dart';
import '../themes/colors.dart';
import '../config/serverAddressesRequests.dart';
import '../main.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
class Home extends StatefulWidget {
  String typePage;

  Home(this.typePage);

  @override
  _HomeState createState() => _HomeState(typePage);
}

class _HomeState extends State<Home> {
  String typePage;

  _HomeState(this.typePage);
  String userName;
  String userMobile;
  getLoggedInState() async {
    await HelperFunctions.getUserNameSharedPreference().then((value){
      setState(() {
        userName  = value;
      });
    });
  }
  getMobileUserInState() async {
    await HelperFunctions.getUserMobileSharedPreference().then((value){
      setState(() {
        userMobile  = value;
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
  void initState() {
    getLoggedInState();
    getMobileUserInState();
    getImageInState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        drawer:drawer(),
        appBar:AppBar(
         actions: <Widget>[
           Container(
             margin: EdgeInsets.symmetric(horizontal: 16),
               child: InkWell(
                 onTap: ()=>{{setState(()=>{ typePage="notification"})},
                // Navigator.push(context, new MaterialPageRoute(builder: (context)=>new not()))
                 },
                   child: Icon(Icons.notifications_none,color: Colors.white,)))
         ],
         elevation: 0,
          title: Text("زنـاد",style: TextStyle(fontSize: 18),),
          centerTitle: true,
        ),

        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width*.21,
            decoration: BoxDecoration(
              color: themeColors.dark_green,
            ),
          ),
          typePage=="home"?homeContent():typePage=="proflie"?profliePage():typePage=="contactPage"?contactPage():typePage=="setting"?currentTransactions(false):typePage=="abuotOff"?aboutOffice():notification(),
        ],),
      ),
    );
  }
  Widget drawer(){
    ServerAddresses serverAddresses=new ServerAddresses();
    ServerAddressesRequests serverAddressesRequests= new ServerAddressesRequests();
    return Container(
     width: MediaQuery.of(context).size.width*0.75,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: themeColors.materialThemeSecondary,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height* 0.3,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: themeColors.dark_green,
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          elevation: 10,
                          child: userImage==null? Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image:  AssetImage('assets/profile.png',)
                              ))):ClipOval(
                            // radius: 45,
                            child: Image.memory(bytes,fit: BoxFit.fitWidth,height: 80.0,width: 80.0,),
                          ),

                        ),
                        SizedBox(height: 16,),
                        userName==null? Padding(
                          padding: EdgeInsets.all(2.0),
                          child:Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(onTap:()=>Navigator.pushNamed(context, '/register'),
                                  child: Text(" تسجيل الدخول  |  ",style: TextStyle(color: Colors.white),)) ,//Text("مصعب ابراهيم الغامدي")
                              InkWell(onTap:()=>Navigator.pushNamed(context, '/login'),
                                 child: Text("تسجيل حساب جديد",style: TextStyle(color: Colors.white),)) ,//Text("مصعب ابراهيم الغامدي")
                            ],
                          )
                        ):Column(
                          children: [
                           Text(userName, style:  TextStyle(color: Colors.white)),
                            RichText(
                              text: TextSpan(//جدة-حي الرويس
                              //  text:"العنوان" ,//user[0]['City']==null?"العنوان":user[0]['City'],
                                  style:TextStyle(fontWeight: FontWeight.bold,color:  Colors.white ,fontFamily: 'Schyler',) ,
                                  children: <TextSpan>[
                                    TextSpan(text:"$userMobile",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))
                                  // user[0]['Mobile'] !=null? TextSpan(text:"  |   ${user[0]['Mobile']}  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45)):TextSpan(text:"  |  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45)),
                                  ]),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                         // child: Text("جدة | 996656"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              CustomListTitle("الرئيسية",()=>{setState(()=>{ typePage="home",Navigator.pop(context)},)}),
              userName==null?Container():CustomListTitle("حسابي",()=>{setState(()=>{ typePage="proflie",Navigator.pop(context)})}),
              userName==null?Container():CustomListTitle(" معاملات الحالية",()=>{setState(()=>{typePage="setting",Navigator.pop(context)})}),
              //  CustomListTitle("الخدمات الرئيسية",()=>{Navigator.push(context, new MaterialPageRoute(builder: (context)=>new servicesScreens()))}),
             // CustomListTitle("طلب معاملة جديدة",()=>{Navigator.push(context, new MaterialPageRoute(builder: (context)=>new requestNewTransactionextends()))}),
              CustomListTitle("عن المكتب",()=>{setState(()=>{typePage="abuotOff",Navigator.pop(context)})}),
              CustomListTitle("بيانات التواصل",()=>{setState(()=>{typePage="contactPage",Navigator.pop(context)})}),

              SizedBox(height: MediaQuery.of(context).size.height * 0.20,),
              MediaQuery.of(context).size.height> 743.4285714285714? SizedBox(height: 25,):Container(),

              Spacer(),
              userName==null?Container(): Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color:Colors.grey.withOpacity(.6)
                ),
              ),

              userName==null?Container(): InkWell(
                onTap: ()=>{serverAddresses.Logout(),
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_){
                        return MyApp();
                      }),(route)=> false
                  )
                },
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text("تسجيل الخروج",style: TextStyle(color: themeColors.dark_green),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  // widget titleName(){
  //   return
  // }



}
class CustomListTitle extends StatelessWidget{
  String title;

  CustomListTitle(this.title, this.onTap);

  Function onTap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Padding(
     padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
     child: InkWell(
       splashColor:  themeColors.dark_green,
       onTap: onTap,
       child: Container(
         height: MediaQuery.of(context).size.height * 0.05,
         child: Row(
           children: <Widget>[
             Text(title,style: TextStyle(color: Colors.white),),
             Spacer(),
           Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
           ],
         ),
       ),
     ),
   );
  }

}
