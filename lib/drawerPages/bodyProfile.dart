import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
class bodyProfile extends StatefulWidget {
  @override
  _bodyProfileState createState() => _bodyProfileState();
}

class _bodyProfileState extends State<bodyProfile> {
  @override
  Widget build(BuildContext context) {
    var call;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
        child: Container(
           // height: MediaQuery.of(context).size.height* 0.4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                headerBody(),
               // lineSlider(),
                call==0?Container(height: MediaQuery.of(context).size.height* 0.4,):Container(),
                currentTransactions(true,call:(val){}),
                // Text("تجديد تصريح عمل",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                // Text("   لدى وزارة العمل والموارد البشرية",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45,fontSize: 10)),
                // Container(
                //   height: 1,
                //   // margin: EdgeInsets.only(top: 8),
                //   decoration: BoxDecoration(
                //       color:Colors.grey[200]
                //   ),
                // ),
              ],
            )
        ),
      ),
    );
  }
 Widget headerBody(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: "المعاملات ",
              style:TextStyle(fontWeight: FontWeight.bold,color: themeColors.dark_green) ,
              children: <TextSpan>[
                TextSpan(text:"الحالية",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45)),
              ]),),
        Icon(Icons.arrow_forward_ios,color: themeColors.dark_green,size: 16,)
      ],
    );
  }
  Widget lineSlider(){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 1,
         // margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color:Colors.grey.withOpacity(.6)
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              tric(),
              tric(),
              tric(),
              tric()
            ],

        )
      ],
    );
  }
  Widget tric(){
    return   Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 2,color: Colors.white),
          color: Color(0xFF007A43)),
      child: Icon(Icons.done,color: Colors.white,size: 22,),
    );
  }
  Widget titleTric(String title){
    return   Container(
      padding: EdgeInsets.all(2),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 2,color: Colors.white),
         // color: Color(0xFF007A43)
      ),
      child: Text(title,style: TextStyle(fontSize: 12),),
    );
  }
}
