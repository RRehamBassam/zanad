import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
import 'package:zanad_app/items/singleAttachment.dart';
import 'package:zanad_app/items/singleAttachmentfill.dart';
import 'package:zanad_app/screens/done.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';

import '../themes/colors.dart';
class editReq extends StatefulWidget {
  int id;
  RequestData requestData;
  var note;

  editReq(this.id, this.requestData,this.note);

  @override
  _editReqState createState() => _editReqState(id,requestData,note);
}

class _editReqState extends State<editReq> {
  int id;
  var note;
  String noteNew;
  String noteNew2;

  _editReqState(this.id, this.requestData,this.note);
 String attachment;
  RequestData requestData;
  int selectedRadioTile;
  int selectedRadio;
var  userId;
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
  ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
    @override
  void initState() {
      getIdInState();
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
    selectedRadioTile =int.parse(requestData.paymentMehtod);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: <Widget>[
          background(),
          ListView(
            children: <Widget>[
              body(),
              payment(),
              Button()            ],
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
  Widget body(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),

    child: Material(
    elevation: 2,
    borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    height: MediaQuery.of(context).size.height*0.8,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(16),
    // color: Colors.white,
    child: Expanded(
        child: Column(
        children: <Widget>[
        title(),
            SizedBox(height: 16,),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Attachment(" ",(val){
                   setState(() {
                     attachment=val;
                   });
                  }),
                  Container(
                    width: 0.4,
                    height: 120,
                    decoration: BoxDecoration(
                        color:Colors.grey[200]
                    ),
                  ),
                  Attachment("",(val){}),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color:Colors.grey[200]
                ),
              ),
              Text("مرفقات أخرى"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Attachment(" ",(val){}),
                  Container(
                    width: 0.4,
                    height: 120,
                    decoration: BoxDecoration(
                      color:Colors.grey.withOpacity(.4),
                    ),
                  ),
                  Attachment("  ",(val){}),

                ],
              ),
              SizedBox(height: 16,),

              TextFormField(
                autofocus: false,
            initialValue: note[1]!=null?note[1]:"",
                onChanged: (val){
                  setState(() {
                    noteNew=val;
                  });
                },
                keyboardType:TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "مرفقات أخرى",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                ),),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: note[0]!=null?note[0]:"",
                onChanged: (val){
                  setState(() {
                     noteNew2=val;

                  });
                },
                autofocus: false,
                keyboardType:TextInputType.visiblePassword,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: " ملاحظات",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                ),),
           ]
    )])))));}
  Widget title(){
    return   Align(alignment:Alignment.centerRight,
        child: Text("تعديل الطلب",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 18)));
  }
  payment(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
    child: Material(
    elevation: 2,
    borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    height: MediaQuery.of(context).size.height*0.4,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(4),
    // color: Colors.white,
    child:
    Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("آلية الدفع",textDirection: TextDirection.rtl,style: TextStyle(color:  themeColors.dark_green,fontSize: 18)),
        SizedBox(height: 8,),
        Text("اختر الطريقة التى تود الدفع من خلالها",textDirection: TextDirection.rtl,style: TextStyle(color:  Colors.black,fontSize: 14)),
        RadioListTile(
          value: 1,
          groupValue: selectedRadioTile,
          title: Row(children: <Widget>[
            Image.asset("assets/Payment.png",scale: 4.5,),
            SizedBox(width: 8,),Text("الدفع عن طريق بطاقة الإتمان",style:TextStyle(fontSize: 12,color: Colors.black),),]),
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
          title: Row(children: <Widget>[
            Image.asset("assets/PaymentTwo.png",scale: 4.5,),
            SizedBox(width: 4,),
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
            SizedBox(width: 4,), Text("الدفع عند الاستلام",style:TextStyle(fontSize: 12,color: Colors.black))]),
          //subtitle: Text("Radio 2 Subtitle"),
          onChanged: (val) {
            print("Radio Tile pressed $val");
            setSelectedRadioTile(val);
          },
          activeColor:  themeColors.dark_green,
          secondary: Text(""),
          selected: false,
        ),
      ],
),
    )));
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });}
  Widget Button(){
    return   InkWell(
      onTap:(){
        serverAddressesRequests.UpdateRequest(id,requestData.paymentMehtod,userId,"${noteNew}#${noteNew2}#","",attachment);
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
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Center(
          child: Text(" تأكيد",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
