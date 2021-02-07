import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/components/returnDiolog.dart';
import 'package:zanad_app/components/darkLine.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
import 'package:zanad_app/config/serverAddressesRequests.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
import 'package:zanad_app/items/singleAttachmentfill.dart';
import 'package:zanad_app/screens/doneRep.dart';
import '../themes/colors.dart';
import 'package:zanad_app/Request/editRequest.dart';
import '../config/serverAddressesRequests.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/screens/home.dart';
class representativeProfile extends StatefulWidget {
  int id;
  RequestData requestData;
  int IdIsReceived;
  representativeProfile(this.id,this.requestData,this.IdIsReceived);

  @override
  _representativeProfileState createState() => _representativeProfileState(id,requestData,IdIsReceived);
}

class _representativeProfileState extends State<representativeProfile> {
  int id;
  int IdIsReceived;
  String userId;
  RequestData requestData;
  _representativeProfileState(this.id,this.requestData,this.IdIsReceived);
 // var AllRequest;
  ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
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
  // getLoggedInState() async {
  //   print("$id id page");
  //
  //   await serverAddressesRequests.Requests(id).then((value){
  //     setState(() {
  //       AllRequest  = value;
  //     });
  //   });
  // }
  getinitState() async {
    await getIdInState();
   // getLoggedInState();
  }
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
      });
    });
  }


  @override
  void initState() {
    getinitState();
    getDelegateRequestState();
    //  Profile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
    return  Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
            child: Container(
                height: MediaQuery.of(context).size.height*0.85,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: FutureBuilder<dynamic>(
              future: serverAddressesRequests.Requests(id),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> name = snapshot.data['SendDate'].split("T");
                  List<String> note = snapshot.data['Note'].split("#");
                  print(snapshot.data['level']);
                //  print("llllll");
                  String PaymentMethodId;
                  snapshot.data['PaymentMethodId']==1?PaymentMethodId= "السداد عند الاستلام":snapshot.data['PaymentMethodId']==2?PaymentMethodId="السداد عن طريق بطاقة الصراف":snapshot.data['PaymentMethodId']==3?PaymentMethodId="السداد عن طريق بطاقة الائتمان":PaymentMethodId="السداد عن طريق سداد";
                   print(snapshot.data['level']);
                return Stack(
                  children: [
                ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text("تفاصيل الطلب" ,style: TextStyle(color: themeColors.dark_green,fontSize: 16)),
                  SizedBox(height: 16,),
                  lineSlider(snapshot.data['level']),

                  SizedBox(height: 16,),
                  structure(//تجديد تصريح عملrequestData//requestData.ServiceName
                  Text(snapshot.data['ServiceName'],style: TextStyle(color: Colors.black,fontSize: 14)),
                  Text(" لدى وزارة العمل والموارد البشرية",style: TextStyle(color: Colors.black45,fontSize: 11)),
                  Text(requestData.cost.toString(),style: TextStyle(color: Colors.black45,fontSize: 14)),
                  Text(" سعر المعاملة",style: TextStyle(color: Colors.black45,fontSize: 10)),
                  ),
                  darkline(),
                  structure(
                  Text("عنوان التسليم",style: TextStyle(color: Colors.black,fontSize: 10)),
                  Text("جده-شارع الرويس بناية رقم5        ",style: TextStyle(color: Colors.black45,fontSize: 10)),
                  Text("تاريخ التسليم",style: TextStyle(color: Colors.black45,fontSize: 14)),
                  RichText(
                  text: TextSpan(
                  style:TextStyle(fontWeight: FontWeight.bold,color:  Colors.black45) ,
                  children: <TextSpan>[
                  //"الثلاثاء 28-11 2017" لساعة(4 - 5م)
                  TextSpan(text:name[0],style: TextStyle(color: Colors.black45,fontSize: 10)),
                  TextSpan(text:"\n   ${name[1]}",style: TextStyle(color: Colors.black45,fontSize: 10)),
                  ]),
                  )
                  ),
                  darkline(),
                  structure(
                  Text("الية الدفع ",style: TextStyle(color: Colors.black,fontSize: 10)),
                  Text("$PaymentMethodId         ",style: TextStyle(color: Colors.black45,fontSize: 10)),
                  Text("حالة المعاملة",style: TextStyle(color: Colors.black45,fontSize: 14)),
                  Text(snapshot.data['PriorityOfRequest'],style: TextStyle(color: Colors.black45,fontSize: 10)),
                  ),
                  SizedBox(height: 10,),
                  Text("المرفقات" ,style: TextStyle(color: Colors.black45,fontSize: 12)),

                  SizedBox(height: 5,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Attachmentfill("صورة هوية"),
                  Attachmentfill("مستند استلام وثيقة"),
                  Attachmentfill("مرفقات آخرى")
                  ],
                  ),
                  SizedBox(height: 5,),
                 // Text("ملاحظات" ,style: TextStyle(color: Colors.black45,fontSize: 12)),
                 // Text(note[0]),
                  // TextField(
                  //   autofocus: false,
                  //   keyboardType:TextInputType.visiblePassword,
                  //   decoration: InputDecoration(
                  //     hintText: " ",
                  //     hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                  //   ),),
                  SizedBox(height: 20,),

                  ],
                  ),
                    Positioned(
                      bottom: 6,
                     left: 5,
                     right: 5,
                     child:           isRepresentative?  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Button("تم الإستلام",(){//Navigator.pushNamed(context, '/doneRep');
                           serverAddressesRequests.IsRecevid(IdIsReceived);
                           Navigator.push(context, new MaterialPageRoute(builder: (context)=>doneRep(id,IdIsReceived)));}),
                         Button("ارجاع",(){
                           String ReasonToReturn;
                           dialogFunction();
                         } ,),

                       ],
                     ):
                     ButtonEdit("تعديل الطلب ",(){ Navigator.push(context, new MaterialPageRoute(builder: (context)=>new editReq(snapshot.data['Id'],RequestData(snapshot.data['ServiceName'],1,snapshot.data['PaymentMethodId'].toString()),note)));
                     }),
                    )
                  ],
                );
                }
                else if (snapshot.hasError) {
                  return Center(child: Text("تأكد من إتصال بالإنرنت"));
                }
                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());}),

            ));
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
  Widget lineSlider(String state){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
        width:  MediaQuery.of(context).size.width*0.68,
          height: 1,
          margin: EdgeInsets.only(bottom: 22),
          decoration: BoxDecoration(
              color:Colors.grey.withOpacity(.6)
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              tric(state=="تحقق المعاملة" || state==null),   titleTric("تحقق المعاملة"),]),
             Column(children: <Widget>[
               tric(state=="قيد العمل"), titleTric("قيد العمل"),]),
             Column(children: <Widget>[ tric(state=="جاهز لتسليم"), titleTric("جاهز لتسليم"),]),
            Column(children: <Widget>[ tric(state=="تم الإلغاء"), titleTric("تم الغاءها")])
          ],

        )
      ],
    );
  }
  Widget tric(bool stute){
    return   Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 2,color: Colors.white),
          color:stute ?Color(0xFF007A43):Colors.grey),
      child: Icon(Icons.done,color: Colors.white,size: 22,),
    );
  }
  void dialogFunction()async{
    String ReasonToReturn;
    final action =
        await  Dialogs.yesAbortDialog(context, 'My title', 'My Body',(val){setState(() {ReasonToReturn=val;});
    });
    if (action == DialogAction.yes) {
      setState((){
        print(userId);
        print(id);
        print(IdIsReceived);
        print(ReasonToReturn);
        serverAddressesRequests.DeliverdRequest(userId,id,IdIsReceived,false,ReasonToReturn,false);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_){
              return Home("home");
            }),(route)=> false
        );
      });
    } else {
      setState((){

      } );}
  }
  Widget structure(Widget widget1,Widget widget2,Widget widget3,Widget widget4){
    return Row(

      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.37,
          child: Column(          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            widget1,
            widget2
          ],),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          width: 0.4,
          height: 40,
          decoration: BoxDecoration(
              color:Colors.grey.withOpacity(.4)
          ),
        ),
        Column(

          children: <Widget>[
          widget3,
          widget4
        ],),
      ],
    );
  }
  Widget Button(String titleButton,Function onTap){
    return   InkWell(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width*0.35,
        padding: EdgeInsets.only(top:4,bottom: 8),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(titleButton,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
  Widget ButtonEdit(String titleButton,Function onTap){
    return   InkWell(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
      //  width: MediaQuery.of(context).size.width*0.75,
        padding: EdgeInsets.only(top:8,bottom: 12),
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Center(
          child: Text(titleButton,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
