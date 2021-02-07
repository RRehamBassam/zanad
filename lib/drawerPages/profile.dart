import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/components/imageProfile.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
import 'package:zanad_app/homePages/profileRep.dart';
import 'package:zanad_app/representative/representativeProfile.dart';
import 'package:zanad_app/screens/editProfile.dart';
import 'package:zanad_app/screens/requestnewTransaction.dart';
import '../themes/colors.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'bodyProfile.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
class profliePage extends StatefulWidget {
  @override
  _profliePageState createState() => _profliePageState();
}

class _profliePageState extends State<profliePage> {
var  user;
String userId;
String userImage;
ServerAddresses serverAddresses=new ServerAddresses();
 // getLoggedInState() async {
 //   await serverAddresses.Profile(userId).then((value){
 //       setState(() {
 //         user  = value;
 //       });
 //     });
 //  }
getinitState() async {
  await getIdInState();
 // getLoggedInState();
 }
  getIdInState() async {
  await HelperFunctions.getUserIdSharedPreference().then((value){
    setState(() {
      userId  = value;
      print(userId);
      ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
      serverAddressesRequests.RequestsAll();
    });
  });
}
Uint8List bytes;
getImageInState() async {
  await HelperFunctions.getUserImageSharedPreference().then((value){
    setState(() {
      userImage  = value;
       bytes = convert.base64.decode(userImage);
    });
  });
}
  bool isRepresentative=false;
getDelegateRequestState() async {
  await HelperFunctions.getUserIsRecevidSharedPreference().then((value){
    setState(() {
      if(value=="User" || value==null ){
        isRepresentative  = false;
      }
      else {
        isRepresentative  = true;
      }
    });
  });
}
  @override
  void initState() {
    getinitState();
    getDelegateRequestState();
    getImageInState();
  //  Profile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<dynamic>(
        future: serverAddresses.Profile(userId),
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        print("${snapshot.data['info'][0]['UserPhohot']} kkkk");
        HelperFunctions.saveUserNameSharedPreference(snapshot.data['info'][0]['FullName']);
        return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              headerProfile(snapshot.data),
              SizedBox(height: 4,),//representativeProfile()
              isRepresentative? profileRep():
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Box(snapshot.data),
                    SizedBox(height: 8,),
                    bodyProfile(),
                 //   Button()
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Material(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              elevation: 4,
              child:userImage==null?  Container(
                alignment: Alignment.topCenter,
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/profile.png',)
                    )),):

          ClipOval(
         // radius: 45,
          child: Image.memory(bytes,fit: BoxFit.fitWidth,height: 100,width: 100,),
            ),

          ),
        )
      ],
    ); }
      else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      // By default, show a loading spinner.
      return Center(child: CircularProgressIndicator());
        },
    );
  }
  Widget headerProfile(var data){
    return Stack(
            children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Material(
            elevation: 2,
            borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
                child: Container(
                height: MediaQuery.of(context).size.height* 0.2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top:8,right: 8,bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                   child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //UserPhohot//Image.network(data['info'][0]['UserPhohot'],scale: 2.5,)
                         Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           InkWell(onTap: ()=>{Navigator.push(context, new MaterialPageRoute(builder: (context)=>new editProfile()))},
                             child: Image.asset("assets/editProfile.jpg",scale: 2.5,)),  Spacer(),
                 ],
               ),
                     Spacer(),
                    //Text("مصعب ابراهيم", style: TextStyle(color: themeColors.dark_green)),
                    data==null?Text("مصعب ابراهيم", style: TextStyle(color: themeColors.dark_green)):Text(data['info'][0]['FullName'], style: TextStyle(color: themeColors.dark_green)),

                    RichText(
                      text: TextSpan(//جدة-حي الرويس
                          text: data==null?"العنوان":data['info'][0]['City'],
                          style:TextStyle(fontWeight: FontWeight.bold,color:  Colors.black45 ,fontFamily: 'Schyler',) ,
                          children: <TextSpan>[
                            data !=null? TextSpan(text:"${data['info'][0]['Mobile']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45)):TextSpan(text:"  |  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45)),
                          ]),),
                  ],
                )

      ),
    ),
          ) ,
            ],
    );
  }
  Widget Box(var data){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
            height: MediaQuery.of(context).size.height* 0.2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               sigleItemBox("${data['inProgressDocument']}","قيد التنفيذ"),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 4),
                 width: 1,
                 height: 20,
                 color: Colors.grey.withOpacity(0.4),
               ),
               sigleItemBox("${data['finishedDocument']}","معاملة سابقة"),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 4),
                 width: 1,
                 height: 25,
                 color: Colors.grey.withOpacity(0.4),
               ),
               sigleItemBox("${data['cancledDocument']}","تم إلغائها")],

            )
        ),
      ),
    );
  }
Widget sigleItemBox(String num,String caseNum){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(num,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: themeColors.dark_green),),
        Text(caseNum,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.8)),)
      ],
    );
}
  Widget Button(){
    return   InkWell(
      onTap:(){
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new requestNewTransactionextends()));

      } ,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),

        child: Center(
          child: Text("تقديم طلب جديد",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
