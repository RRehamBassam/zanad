import 'package:flutter/material.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/items/singleNotification.dart';
import 'package:zanad_app/themes/colors.dart';
class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  String userId;

  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
        print(userId);


      });
    });
  }
  @override
  void initState() {
    getIdInState();
    //TODO: implement initState
  super.initState();
  }

  ServerAddresses serverAddresses=new ServerAddresses();
 // NotificationsUser()
  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration: BoxDecoration(
          color:Colors.white,
        borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
            //  borderRadius: BorderRadius.all()
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child:Material(
        elevation: 4,
        borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
        child: Container(
          child:FutureBuilder<dynamic>(
          future: serverAddresses.NotificationsUser(userId),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
            return  Expanded(
           child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 16,top: 16,bottom: 16),
                  child: Text("الإشعارات",style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 18),)),
              ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:snapshot.data['notifications'].length,
              itemBuilder: (context, index) {
                // print(AllRequest.length);
                //themeString.complete
                return Column(
                  children: [
                        singleNotification(snapshot.data['notifications'][index]['Text'],snapshot.data['notifications'][index]['Date']),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height:1,
                      decoration: BoxDecoration(
                          color:Colors.grey.withOpacity(.6)
                      ),
                    ),
                  ],
                );
              }  ),

            ],
          ));}
              else if (snapshot.hasError) {
            return Text("تأكد من إتصال بالإنترنت");
          }
    // By default, show a loading spinner.
    return Center(child: CircularProgressIndicator());
    },
    )

          ),),
    );
  }
}
