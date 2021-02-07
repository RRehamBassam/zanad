import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'package:zanad_app/config/server_addersses.dart';
class aboutOffice extends StatefulWidget {
  @override
  _aboutOfficeState createState() => _aboutOfficeState();
}

class _aboutOfficeState extends State<aboutOffice> {
  @override
  Widget build(BuildContext context) {
    ServerAddresses serverAddresses=new ServerAddresses();
    return  Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width*.21,
          decoration: BoxDecoration(
            color: themeColors.dark_green,
          ),
        ),

        Container(
            margin:EdgeInsets.all(16) ,
          child:  Material(
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
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text("عن المكتب",style: TextStyle(fontWeight: FontWeight.bold,color:  themeColors.dark_green,fontSize: 16)),
              SizedBox(height: 16,),
              FutureBuilder<dynamic>(
                  future: serverAddresses.AboutUs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data["aboutus"],style: TextStyle(fontSize: 14));
                    }
                    else if (snapshot.hasError) {
                      return Center(child: Text("تأكد من إتصال بالإنرنت"));
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());}),

            ],



    ))),
            ),

      ]);
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
}
