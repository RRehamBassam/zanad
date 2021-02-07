import 'package:flutter/material.dart';
import 'package:zanad_app/Request/maps.dart';
import 'package:zanad_app/components/textfeild.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/design/designbackgroundbutton.dart';
import 'package:zanad_app/items/singleAttachment.dart';
import 'package:zanad_app/models/req.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
class requestNewTransactionextends  extends StatefulWidget {
  var idServices;
  String name;

  requestNewTransactionextends({this.idServices,this.name});

  @override
  _requestNewTransactionextendsState createState() => _requestNewTransactionextendsState(idServices:idServices,name: name);
}

class _requestNewTransactionextendsState extends State<requestNewTransactionextends> {
  var idServices;
  String name;
  _requestNewTransactionextendsState({this.idServices,this.name});
  double _currentSliderValue = 0;
  String  _currentSliderText ="عادي";
  String priority;
  String notes;
  String notes1;
  String notes2;
  String Attachmentimg;
  String Attachmentimg1;
  String Attachmentimg2;
  String Attachmentimg3;
  TextEditingController _note = new TextEditingController();
  String Id;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        Id = value;
      });
    });
  }
  @override
  void initState() {
    priority="3";
    getIdInState();
    getIdInState();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: <Widget>[

          background(),
          Container(
            decoration:Characteristics.boxDecoration,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Column(
              children: <Widget>[
                body(),
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
  Widget title(){
    return   Text("طلب معاملة جديدة",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 18));
  }
  Widget body(){
    return Expanded(
      child: ListView(
        children: <Widget>[
          title(),
          SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("حالة معاملة ",textDirection: TextDirection.rtl,),
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 2,
                activeColor: themeColors.dark_green,
                inactiveColor: Colors.grey[350],
                label: _currentSliderText.toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    if(_currentSliderValue>50) {
                      _currentSliderText="عاجل";
                      priority="عاجل";
                    }else if(_currentSliderValue==50){
                      _currentSliderText="متوسط";
                      priority="متوسط";
                    }else {
                      _currentSliderText="عادي";
                      priority="عادي";
                    }
                  });
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("عادي ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12,color: themeColors.dark_green),),
                    Text("  متوسط",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12,color: themeColors.dark_green),),
                    Text("عاجل ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12,color: themeColors.dark_green),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 15),
                padding:EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width*0.75,
                decoration: BoxDecoration(
                  color: Colors.grey[200]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("حالة المعاملة   ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12),),
                  priority=="عادي"?Text("هذه المعاملة تحتاج مدة من 7 الى 10 الايام  ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 10)): priority=="متوسط"?Text("هذه المعاملة تحتاج مدة من 5 الى 7 الايام  ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 10)):Text("هذه المعاملة تحتاج مدة من 1 الى 5 الايام  ",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),

            ],
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.41,
                  child: Attachment("صورة الهوية",(val){
                    setState(() {
                      Attachmentimg1=val;
                    });

                  })),
              Container(
                width: 0.4,
                height: 120,
                decoration: BoxDecoration(
                    color:Colors.grey[200]
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width*0.41,
                  child: Attachment("مستندات استلام الوثيقة",(val){
                   setState(() {
                     Attachmentimg2;
                   });
                  })),
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
              Container(
                  width: MediaQuery.of(context).size.width*0.41,
                  child: Attachment(" ",(val){
                    setState(() {
                      Attachmentimg3=val;
                    });
                  })),
              Container(
                width: 0.4,
                height: 120,
                decoration: BoxDecoration(
                    color:Colors.grey[200]
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width*0.41,
                  child: Attachment("  ",(val){
                    setState(() {
                      Attachmentimg=val;
                    });
                  })),
            ],
          ),
          SizedBox(height: 16,),
      textFeild(
        hintText: "مرفقات أخرى",
         callback: (val){setState(() {
           notes1==val;
         });}
      ),
          SizedBox(height: 16,),
          textFeild(
            hintText: "مرفقات أخرى",
              callback: (val){
              setState(() {
                notes2==val;
              });
              }
            ),
          SizedBox(height: 20,),
          TextField(
            onChanged: (val){setState(() {
              notes=val;
            });

            },
           // controller: _note,
            autofocus: false,
            keyboardType:TextInputType.visiblePassword,
            minLines: 2,
            maxLines: 5,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),


              labelStyle: new TextStyle(
                color: Colors.grey[200],
              ),
              hintText: " ملاحظات",
              hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
            ),),
          SizedBox(height: 16,),
          Button(idServices,"","",Id,"${notes}#${notes1}#${notes2}",priority,Attachmentimg1,name),
        ],
      ),
    );
  }
  Widget Button(int ServiceId,String ChoosedLocationsId, String PaymentMethodId,String UserId, String note,String priority,Attachmentimg,String name){
    ServerAddresses  serverAddresses=new  ServerAddresses();
    return   InkWell(
      onTap:(){
        print(ServiceId);
        print(UserId);
        print(note);
        print(priority);
        print(Attachmentimg);
       // serverAddresses.AddAttachment2(Attachmentimg1,Attachmentimg2);
        //serverAddresses.AddRequest(ServiceId,"",1,UserId,"$note",priority,Attachmentimg,name);
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new maps(new Req(ServiceId,"","",UserId,"$note",priority,Attachmentimg,name))));
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 5,bottom: 14),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("التالي",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

