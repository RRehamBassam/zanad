import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'package:zanad_app/items/singleServices.dart';
import 'package:zanad_app/config/server_addersses.dart';


class servicesScreens extends StatefulWidget {
  @override
  _servicesScreensState createState() => _servicesScreensState();
}

class _servicesScreensState extends State<servicesScreens> {
  var Services;
  int lenServices;
  ServerAddresses serverAddresses=new ServerAddresses();
  // getLoggedInState() async {
  //   await serverAddresses.Services().then((value){
  //     setState(() {
  //       Services  = value;
  //       lenServices= Services.length;
  //     });
  //   });
  // }
  bool isRepresentative=false;

  @override
  void initState() {
    lenServices=0;
  //  getLoggedInState();
    //  Profile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Material(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          child:
              FutureBuilder<dynamic>(
              future: serverAddresses.Services(),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
                     return Column(
                         children: <Widget>[
                         title(snapshot.data.length),
                       SizedBox(height: 16,), body(snapshot.data,snapshot.data.length)],
                     );}
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
              },
              ),

        ),
      ),
    );
  }
  AppBar appBar(){
    return AppBar(
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

  Widget title(int lenServices){
    return  Row(
      children: <Widget>[
        Text("خدماتنا",style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 18)),
        Spacer(),
        Text("(${lenServices})",style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green))
      ],
    );
  }
  Widget body(var services,var lenServices){
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,

        childAspectRatio: 45/ 60,
        children: List.generate(lenServices, (index) {
          return Center(
            child:singleServices(Name:services[index]['Name'],pic:services[index]['pic'],id:services[index]['id']),
          );
        }),
      ) ,
    );
  }
}
