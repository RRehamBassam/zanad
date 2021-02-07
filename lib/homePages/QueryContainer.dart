import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
import 'package:zanad_app/screens/reqState.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
class queryBox extends StatefulWidget {
  @override
  _queryBoxState createState() => _queryBoxState();
}

class _queryBoxState extends State<queryBox> {
  String userId;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
      });
    });
  }
  @override
  void initState() {
    getIdInState();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Material(
        elevation: 2,
          borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
          child: Container(
          //  margin: EdgeInsets.only(top: 16),
          height: 150,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration:Characteristics.boxDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title(),
                Text("  بامكانك تتبع حالة معاملاتك التي قمت بتقديما",style: TextStyle(fontSize: 12,color:Colors.grey ),),
                SizedBox(height: 6,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: <Widget>[
                  transactionNum(),
                    SizedBox(width: 5,),
                    searchBox(),
                  ],),
                )

              ],
            ),
          )
      ),
    );
  }
  var searchWord;
 Widget transactionNum(){
    return  Container(
      padding: EdgeInsets.all(4),
     height: 45,
     width: MediaQuery.of(context).size.width* 0.65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:Border.all(color: Colors.grey[300],width: 1)
      ),
      child: Row(
        children: <Widget>[
          Text("رقم المعاملة" ,style: TextStyle(fontSize: 14),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 1,
            height: 20,
            color: Colors.grey.withOpacity(0.4),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width* 0.3,
            child: TextField(onChanged: (val)=>setState((){searchWord=val;}),
              cursorColor: themeColors.dark_green,
              keyboardType:TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "XXXXXXXX",
                hintStyle: TextStyle(color: Colors.grey[400]),
                labelStyle: null
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget title(){
    return RichText(
      text: TextSpan(
          text: "الاستعلام ",
          style:TextStyle(color:  themeColors.dark_green,fontFamily: 'Schyler') ,
          children: <TextSpan>[
            TextSpan(text:"عن المعاملة",style: TextStyle(color: Colors.black,fontFamily: 'Schyler')),
          ]),);
  }
  var result;
  ServerAddresses serverAddresses=new ServerAddresses();
  getLoggedsignupState() async {
    await serverAddresses.Search(userId,searchWord).then((value){
      setState(() {
        result  = value;
      });

    });
  }

  Widget searchBox(){

    return  InkWell(
      onTap: ()async{
       await getLoggedsignupState();
       // serverAddresses.Search(userId,searchWord),
        if(result.length==0){
        Fluttertoast.showToast(
        msg: "No result",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: themeColors.dark_green.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 16.0
    );
        }else
       Navigator.push(context, new MaterialPageRoute(builder: (context)=>new reqState(int.parse(searchWord),RequestData("",1,"1"))));
      },

      child: Container(
        padding: EdgeInsets.all(8),
        //width: MediaQuery.of(context).size.width *0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: themeColors.dark_green,
            //border:Border.all(color: Colors.black26,width: 1)
        ),
        child:Icon(Icons.search,color:Colors.white,) ,
      ),
    );
  }
}
