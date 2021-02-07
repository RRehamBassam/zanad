import 'package:flutter/material.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
import 'package:zanad_app/representative/representativeProfile.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
class reqState extends StatefulWidget {
  int id;
  RequestData requestData;
  int IdIsReceived;
  reqState(this.id,this.requestData,{this.IdIsReceived});

  @override
  _reqStateState createState() => _reqStateState(id,requestData,IdIsReceived);
}

class _reqStateState extends State<reqState> {
  int id;
  int IdIsReceived;
  RequestData requestData;
  _reqStateState(this.id,this.requestData,this.IdIsReceived);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
      appBar: appBar(),
      body: Stack(
        children: <Widget>[
          background(),
          Container(
            decoration:Characteristics.boxDecoration,

            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: ListView(
              children: <Widget>[
                representativeProfile(id, requestData,IdIsReceived),
              ],
            ),
          ),
        ],
      ),
    );
  }
  AppBar appBar(){
    return AppBar(
      elevation: 0,
      title:Text("زنـاد",style: TextStyle(fontSize: 18),) ,
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: <Widget>[
        InkWell(onTap: ()=>{Navigator.pop(context)},
            child: Container(
                margin: EdgeInsets.all(16),
                child: Icon(Icons.arrow_forward,color: Colors.white,))
        )],);
  }
  Widget background(){
    return  Container(
      height: MediaQuery.of(context).size.width*.15,
      decoration: BoxDecoration(
        color: themeColors.dark_green,
      ),
    );
  }


}
