
import 'package:flutter/material.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/screens/requestnewTransaction.dart';
import '../themes/colors.dart';

class ServiceInfor extends StatefulWidget {
  var idServices;
  var name;

  ServiceInfor(this.idServices,this.name);

  @override
  _ServiceInforState createState() => _ServiceInforState(idServices,name);
}

class _ServiceInforState extends State<ServiceInfor> {
  var idServices;
  var name;
  String Id;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        Id = value;
        print("$Id id=");

      });
    });
  }

  _ServiceInforState(this.idServices,this.name);
  bool textEerr;
  @override
  void initState() {
    getIdInState();
    textEerr=true;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: appBar(),
      body:  Stack(children: <Widget>[
      Container(
      height: MediaQuery.of(context).size.width*.21,
      decoration: BoxDecoration(
        color: themeColors.dark_green,
      ),
    ),

        Container(
          margin:EdgeInsets.all(16) ,
            child: body( Id)),

      ]),
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
  Widget body(String Id){
    ServerAddresses serverAddresses=new ServerAddresses();
    return Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
            height: MediaQuery.of(context).size.height* 0.85,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 8,right: 4),
                        child: Text(name,textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 18))),
                   //  SizedBox(height: MediaQuery.of(context).size.height* 0.56,),
                    SizedBox(height: 16,),
                    FutureBuilder<dynamic>(
                        future: serverAddresses.ServicesDetails(idServices),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data["data"][0]["Details"]);
                          }
                          else if (snapshot.hasError) {
                            return Center(child: Text("تأكد من إتصال بالإنرنت"));
                          }
                          // By default, show a loading spinner.
                          return Center(child: CircularProgressIndicator());}),



                  ],
                ),
            Positioned(
              bottom: 110.0,
            child:textEerr?Container():Text("يجب عليك تسجيل الدخول أولاً",style:TextStyle(color: Colors.red)),
                ),
                Positioned(
                  bottom: 10.0,
                  child:  InkWell(
                    onTap: (){
                      Id !=null? Navigator.push(context, new MaterialPageRoute(builder: (context)=>new requestNewTransactionextends(idServices:idServices,name:name)))
                          :setState(()=>{
                        textEerr=false
                      });
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color:Color(0xFF007A43) ,
                      ),
                      width: MediaQuery.of(context).size.width*0.7,
                      height: 45,
                      padding: EdgeInsets.only(top: 5,bottom: 14),
                      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                      child: Center(
                        child: Text(" تقديم طلب ",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                )
              ],
            )



        ));
  }
}
