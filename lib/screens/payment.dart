import 'package:flutter/material.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/models/req.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
import 'done.dart';
class Payment extends StatefulWidget {
  Req req;

var addresses;
  Payment(this.req,this.addresses);

  @override
  _PaymentState createState() => _PaymentState(req,addresses);
}

class _PaymentState extends State<Payment> {
  Req req;
var addresses;
  _PaymentState(this.req,addresses);

  int selectedRadioTile;
  int selectedRadio;
  @override
  void initState() {
    super.initState();
    getLoggedInState();
    selectedRadio = 0;
    selectedRadioTile = 1;
  }
  ServerAddresses serverAddresses=new ServerAddresses();
  getLoggedInState() async {
    await serverAddresses.paymentTypes().then((value){
      setState(() {
        //  user  = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
       appBar: appBar(),
      body:Stack(
        children: <Widget>[

        background(),
            Container(
              width: MediaQuery.of(context).size.width,
             height:MediaQuery.of(context).size.height*0.55 ,
             decoration: Characteristics.boxDecoration,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
             child: Column(
                   children: <Widget>[payment() ,]
    ))
    ]));
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
  payment(){
    return  Expanded(
        child: ListView(
    //  crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Text("آلية الدفع",textDirection: TextDirection.rtl,style: TextStyle(color:  themeColors.dark_green,fontSize: 18)),
            SizedBox(height: 8,),
            Text("اختر الطريقة التى تود الدفع من خلالها",textDirection: TextDirection.rtl,style: TextStyle(color:  Colors.black,fontSize: 14)),
        MediaQuery.of(context).size.height> 743.4285714285714? SizedBox(height:20,):Container(),
           RadioListTile(
             value: 1,
             groupValue: selectedRadioTile,
             title: Row(children: <Widget>[

               Image.asset("assets/Payment.png",scale: 4.5,),
               SizedBox(width: 1,),Text("الدفع عن طريق بطاقة الإتمان",style:TextStyle(fontSize: 12,color: Colors.black),),]),
             //  subtitle: Text("Radio 1 Subtitle"),
             onChanged: (val) {
               print("Radio Tile pressed $val");
               setSelectedRadioTile(val);
             },
             activeColor:  themeColors.dark_green,
             secondary: Text(""),
             selected: true,
           ),
        RadioListTile(
        value: 2,
        groupValue: selectedRadioTile,
        title:  Row(children: <Widget>[
            Image.asset("assets/PaymentTwo.png",scale: 4.5,),
            SizedBox(width: 1,),
            Text("الدفع عن طريق بطاقة الصراف",style:TextStyle(fontSize: 12,color: Colors.black)),
          ],),

         // subtitle: Text("Radio 2 Subtitle"),
        onChanged: (val) {
          print("Radio Tile pressed $val");
          setSelectedRadioTile(val);
        },
        activeColor: themeColors.dark_green,
        secondary: Text(""),
        selected: false,
        ),
        RadioListTile(
          value: 3,
          groupValue: selectedRadioTile,
          title:Row(children: <Widget>[
            Image.asset("assets/PaymentThree.png",scale: 4.5,),
            SizedBox(width: 1,), Text("الدفع عند الاستلام",style:TextStyle(fontSize: 12,color: Colors.black))]),
          //subtitle: Text("Radio 2 Subtitle"),
          onChanged: (val) {
            print("Radio Tile pressed $val");
            setSelectedRadioTile(val);
          },
          activeColor:  themeColors.dark_green,
          secondary: Text(""),
          selected: false,
           ),
        MediaQuery.of(context).size.height> 743.4285714285714? SizedBox(height:70,):Container(),

        Button()
      ],
    ));
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  Widget Button(){
    return   InkWell(
      onTap:(){
        print(selectedRadioTile);
       // "تم الإضافة بنجاح"
       // {"requestId":6422,"result":"تم الإضافة بنجاح"}
        serverAddresses.AddRequest(req.ServiceId,"",selectedRadioTile,req.UserId,req.note,req.priority,req.Attachmentimg,req.name,addresses);
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new done()));
       // Navigator.popAndPushNamed(context, '/activateCode');
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
        child: Center(
          child: Text(" التالي",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}


