import 'package:flutter/material.dart';
import 'package:zanad_app/Request/editRequest.dart';
import 'package:zanad_app/components/cancelReq.dart';
import 'package:zanad_app/components/darkLine.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/representative/representativeProfile.dart';
import 'package:zanad_app/screens/reqState.dart';
import 'package:zanad_app/screens/servicesScreens.dart';
import 'package:zanad_app/themes/constent.dart';
import '../themes/colors.dart';
import '../config/serverAddressesRequests.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/drawerPages/CurrentTransactiosRep.dart';
class currentTransactions extends StatefulWidget {
  bool isprofile;
Function(int) call;
  currentTransactions(this.isprofile,{this.call});

  @override
  _currentTransactionsState createState() => _currentTransactionsState(isprofile,call:call);
}


class _currentTransactionsState extends State<currentTransactions> {
  bool isprofile;
  Function(int) call;
  _currentTransactionsState(this.isprofile,{this.call});

  int numberCanceled;
  String userId;
  String result;
  ServerAddressesRequests serverAddressesRequests=new ServerAddressesRequests();
  ServerAddresses serverAddresses=new ServerAddresses();

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
  //serverAddressesRequests.AllRequest();

  getinitState() async {
    await getIdInState();
   // getLoggedInState();
    getDelegateRequestState();
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

    result=null;
    numberCanceled=0;
    //  Profile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin:!isprofile? EdgeInsets.symmetric(horizontal: 16):EdgeInsets.symmetric(horizontal: 4),
      child: isRepresentative?CurrentTransactiosRep(false): !isprofile? headerPage():
      FutureBuilder<dynamic>(
        future: serverAddressesRequests.AllRequest(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.length==0){
              return Container(height: MediaQuery.of(context).size.height* 0.2,);
            }
            return
              ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:snapshot.data.length,
                itemBuilder: (context, index){
                 // print("${snapshot.data.length} jjj" );

                   //print(snapshot.data.length);
                  //themeString.complete
                  if(snapshot.data.length==0){
                    return Container(height: MediaQuery.of(context).size.height* 0.4,);
                  }else return Column(children: [
                   single(themeColors.dark_green,snapshot.data[index]['level'],snapshot.data[index]['ServiceName'],snapshot.data[index]['Id'],snapshot.data[index]['cost'],snapshot.data[index]['paymentMehtod'],snapshot.data[index]['PaymentMethodId'],snapshot.data[index]['Note']),
                    SizedBox(height:16,),
                  ],);
                },
              );}

          else if (snapshot.hasError) {
            return  Center(child: Text("تأكد من إتصال بالانترنت"));;
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

Widget headerPage(){
  print(userId);
  return Material(
            elevation: 4,
            borderRadius:BorderRadius.all(Radius.circular(8.0)) ,
        child: Container(
            height: MediaQuery.of(context).size.height* 0.87,
            width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
          child:ListView(
          children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: RichText(
                  text: TextSpan(
                  text: 'المعاملات ',
                  style:  TextStyle(fontFamily: 'Schyler',color: themeColors.dark_green,fontSize: 16),
                  children: <TextSpan>[
                  TextSpan(text: 'الحالية', style: TextStyle(fontFamily: 'Schyler',color: Colors.black )),
          ],
          ),
                  ),
                ),

            FutureBuilder<dynamic>(

            future: serverAddresses.Profile(userId),
            builder: (context, snapshot) {

            if (snapshot.hasData) {
                   return   rowCaseTran(snapshot.data['inProgressDocument'],snapshot.data['finishedDocument'],snapshot.data['cancledDocument']);}
              else if (snapshot.hasError) {
              return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
            ),
            SizedBox(height: 10,),
             darkline(),
            FutureBuilder<dynamic>(
              future: serverAddressesRequests.AllRequest(userId),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
              return
                  ListView.builder(

                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                   /// physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:snapshot.data.length,
                    itemBuilder: (context, index){

                     //themeString.complete
                      if(snapshot.data.length==0){
                        return null;
                      }else return Column(children: [
                        single(themeColors.dark_green,snapshot.data[index]['level'],snapshot.data[index]['ServiceName'],snapshot.data[index]['Id'],snapshot.data[index]['cost'],snapshot.data[index]['paymentMehtod'],snapshot.data[index]['PaymentMethodId'],snapshot.data[index]['Note']),
                      SizedBox(height:16,),
                    ],);
                    },
                  );}

                  else if (snapshot.hasError) {
                    return  Center(child: Text("تأكد من إتصال بالانترنت"));;
                  }
                  // By default, show a loading spinner.
                  return Center(child: CircularProgressIndicator());
                  },
                  ),
           // single(themeColors.dark_green,themeString.complete),
            SizedBox(height:8,),
           // single(themeColors.dark_green,themeString.complete),
            SizedBox(height:8,),
            //single(Colors.black54,themeString.notcomplete),
          ]
        )));
}
Widget single(Color color,String text,String serviceName,int id,double cost,String IdPayment,int  IdPayment2,note){
  void add(context) async  {
    final action =
    await Dialogs.yesAbortDialog(context, 'My title', 'My Body');
    if (action == DialogAction.yes) {
      setState((){
        numberCanceled++;
        serverAddressesRequests.cancelRequest(id,userId,"");

      } );
    } else {
      setState((){

      } );
      // setState(() => tappedYes = false);
    }

  }
  void choiceAction(String choice){
    if(choice == Constants.Settings){
      List<String> note2 = note.split("#");
      Navigator.push(context, new MaterialPageRoute(builder: (context)=>new editReq(id,RequestData(serviceName,cost,IdPayment2.toString()),note2)));


    }else if(choice == Constants.Subscribe){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=>new reqState(id,RequestData(serviceName,cost,IdPayment))));
    }else if(choice == Constants.SignOut){
      add(context);


    }
  }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width*0.41,
        child: RichText(
          text: TextSpan(// 'تجديد تصريح عمل
            text:serviceName,
            style:  TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'Schyler'),
            children: <TextSpan>[
              TextSpan(text: '\nلدى وزارة العمل والموارد البشرية', style: TextStyle(color: Colors.grey ,fontSize: 10,fontFamily: 'Schyler')),
            ],
          ),
        ),
      ),
      tric(color),
      Container(
          width: MediaQuery.of(context).size.width*0.19,
          child: Center(child: Text(text,style: TextStyle(color: color,fontSize:text==themeString.complete? 14:10 )))),
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context){
            return Constants.choices.map((String choice){
              return PopupMenuItem<String>(
                value: choice,
                child: Center(child: Text(choice)),
              );
            }).toList();
          },
        ),



    ],);
}


Widget rowCaseTran(int inProgressDocument,int finishedDocument,int cancledDocument){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        sigleItemBox("${inProgressDocument}","قيد التنفيذ"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 1,
          height: 20,
          color: Colors.grey.withOpacity(0.4),
        ),
        sigleItemBox("${finishedDocument}","معاملة سابقة"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 1,
          height: 25,
          color: Colors.grey.withOpacity(0.4),
        ),
        sigleItemBox("${cancledDocument}","تم إلغائها")
      ],);
}
Widget tric(Color color){
    return   Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 0.5,color: Colors.white),
          color: color),
      child: Icon(Icons.done,color: Colors.white,size: 18,),
    );
  }
  Widget sigleItemBox(String num,String caseNum){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(num,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: themeColors.dark_green),),
        Text(caseNum,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.8)),)
      ],
    );
  }
}
class RequestData{
 String ServiceName;
 double cost;
  String paymentMehtod;

 RequestData(this.ServiceName, this.cost, this.paymentMehtod);
}