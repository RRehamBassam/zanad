import 'package:flutter/material.dart';
import 'package:zanad_app/themes/colors.dart';
class singleNotification extends StatefulWidget {
  String textbody;
  String time;

  singleNotification(this.textbody, this.time);

  @override
  _singleNotificationState createState() => _singleNotificationState(textbody,time);
}

class _singleNotificationState extends State<singleNotification> {
  String textbody;
  String time;

  _singleNotificationState(this.textbody, this.time);

  @override
  Widget build(BuildContext context) {
    List<String> name = time.split("T");
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          Icon(Icons.notifications_none,color: themeColors.dark_green,),
          Container(
            width: 1,
            margin: EdgeInsets.symmetric(horizontal: 8),
            height:40,
            decoration: BoxDecoration(
                color:Colors.grey.withOpacity(.6)
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                Text("إشعارات",style: TextStyle(fontSize: 14)),
               SizedBox(height:2 ,),
               Text(textbody,style: TextStyle(color: themeColors.dark_green,fontSize: 14),) ,
               SizedBox(height:4 ,),
               Text(name[1],style: TextStyle(color: Colors.grey[400],fontSize: 10)),
             ],
            ),
          ),

          Text(name[0],style: TextStyle(color: Colors.grey[400],fontSize: 10),),
          SizedBox(width:6 ,)
        ],
      ),
    );
  }
}
