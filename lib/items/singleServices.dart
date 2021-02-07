import 'package:flutter/material.dart';
import 'package:zanad_app/screens/ServiceInfor.dart';
import 'package:zanad_app/screens/requestnewTransaction.dart';

class singleServices extends StatefulWidget {
  var Name;
  var pic;
  var id;
  singleServices({this.Name,this.pic,this.id});

  @override
  _singleServicesState createState() => _singleServicesState(Name:Name,pic: pic,idServices:id);
}

class _singleServicesState extends State<singleServices> {
  var Name;
   var pic;
  var idServices;
  _singleServicesState({this.Name,this.pic,this.idServices});
  @override
  Widget build(BuildContext context) {

    return  InkWell(
      onTap: ()=>{
        print(pic),//Navigator.popAndPushNamed(context, '/requestNewTransactionextends')
      Navigator.push(context, new MaterialPageRoute(builder: (context)=>new ServiceInfor(idServices,Name)))},
      child: Container(
       height: 290,
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0))
              ),
              child:pic==null?Image.asset("assets/Services.png"):Image.network("https://zenadapp.com/ZenadApi$pic")//Image.network(pic)
            ),
            SizedBox(height: 4,),
            Text(Name.toString(),style: TextStyle(fontSize: 12),),
           // SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
