import 'package:flutter/material.dart';
import 'package:zanad_app/drawerPages/currentTransactions.dart';
import 'package:zanad_app/themes/colors.dart';
import '../components/checkBox.dart';
import '../config/serverAddressesRequests.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/screens/reqState.dart';
class CurrentTransactiosRep extends StatefulWidget {
  bool isProfile;

  CurrentTransactiosRep(this.isProfile);

  @override
  _CurrentTransactiosRepState createState() => _CurrentTransactiosRepState(isProfile);
}

class _CurrentTransactiosRepState extends State<CurrentTransactiosRep> {
  bool isProfile;
  String userId;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        userId  = value;
      });
    });
  }


  _CurrentTransactiosRepState(this.isProfile);

  bool checkBoxValue=true;
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
    getDelegateRequestState();
    getIdInState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Material(
            elevation: 2,
            borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
            child: Container(
              height:isProfile? MediaQuery.of(context).size.height* 0.5:MediaQuery.of(context).size.height* 0.9,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              child: Column(
                children: <Widget>[
                    Align(
                    alignment: Alignment.topRight,
                    child: RichText(
                    text: TextSpan(
                    text: 'المعاملات ',
                    style:  TextStyle(fontFamily: 'Schyler',color: themeColors.dark_green,fontSize: 16),
                    children: <TextSpan>[
                    TextSpan(text: 'الحالية', style: TextStyle(fontFamily: 'Schyler',color: Colors.black ))]))),
                    SizedBox(height: 10,),
                 // Text("المعاملة الحالية",style: TextStyle(fontSize: 16),),
                    FutureBuilder<dynamic>(
                    future: serverAddressesRequests.DelegateRequest(userId),
                    builder: (context, snapshot) {
                    if (snapshot.hasData) {
                     int length=snapshot.data['requestNeedToDeliverdInfo'].length;
                     var data=snapshot.data['requestNeedToDeliverdInfo'];
                    return
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:isProfile?length<5?length:4:snapshot.data['requestNeedToDeliverdInfo'].length,
                    itemBuilder: (context, index){
                    return singleTransactiosRep(index + 1,snapshot.data['requestNeedToDeliverdInfo'][index]['Serviece'],snapshot.data['requestNeedToDeliverdInfo'][index]['RequestId'],snapshot.data['requestNeedToDeliverdInfo'][index]['cost'],snapshot.data['requestNeedToDeliverdInfo'][index]['IsReceived'],data[index]['Id'],data[index]['AddressPlace']);
                    //themeString.complete
                  //  return single(themeColors.dark_green,AllRequest[index]['level'],AllRequest[index]['ServiceName'],AllRequest[index]['Id'],AllRequest[index]['cost'],AllRequest[index]['paymentMehtod']);
                    },
                    );}   else if (snapshot.hasError) {
                      return  Center(child: Text("تأكد من إتصال بالانترنت"));
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                    },
                    ),
                // singleTransactiosRep(1),
                //  singleTransactiosRep(2)
                ],
              ),
            )));
  }
  Widget singleTransactiosRep(int num,String Name,int id ,double cost,bool IsReceived,int Id,Address){
    List<String> name = Name.split(' ');
if (name.length>3){
  if(Name.length>22){
    Name="${name[0]} ${name[1]} ${name[2]} ...";
  }else{
   name = Name.split(' ');
   Name="${name[0]} ${name[1]} ${name[2]} ${name[3]}";}
}
    return InkWell(
      onTap: ()=> Navigator.push(context, new MaterialPageRoute(builder: (context)=>new reqState(id,RequestData(Name,1,"1"),IdIsReceived:Id))),
      child: Column(
       children: <Widget>[
         Row(
           children: <Widget>[
             Text("$num\-   ",style: TextStyle(fontSize: 16),),
             RichText(
               overflow: TextOverflow.ellipsis,
               text: TextSpan(
                 text:Name,//'تجديد تصريح عمل ',
                // overflow: TextOverflow.ellipsis,
                 style:  TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'Schyler',),
                 children: <TextSpan>[
                   TextSpan(text: '\n لدى وزارة العمل', style: TextStyle(color: Colors.grey ,fontSize: 12,fontFamily: 'Schyler')),
                 ],
               ),
             ),
             Spacer(),
               checkBox(IsReceived,Id),
                 Container(
                   padding: EdgeInsets.only(bottom: 8),
                     child: Text('تم االتسليم',style: TextStyle(color: Colors.black)))
           ],
         ),
         SizedBox(height: 4,),
         Row(
           children: <Widget>[
             SizedBox(width: 27,),
             RichText(
               text: TextSpan(
                 text: 'عنوان التسليم ',
                 style:  TextStyle(color: Colors.grey ,fontSize: 12,fontFamily: 'Schyler'),
                 children: <TextSpan>[
                   TextSpan(text: '\n $Address', style: TextStyle(color: Colors.black,fontSize: 10,fontFamily: 'Schyler')),
                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.symmetric(horizontal:30),
               width: 1,
               height: 20,
               color: Colors.grey[200],
             ),
           ],
         ),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
           height: 1,
           color: Colors.grey[200],
         ),
       ],
      ),
    );

  }
}
