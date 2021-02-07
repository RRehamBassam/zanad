import 'package:flutter/material.dart';
import '../themes/colors.dart';
class boxTrans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
            height: MediaQuery.of(context).size.height* 0.2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                sigleItemBox("2","الطلبات الحالية"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 1,
                  height: 20,
                  color: Colors.grey.withOpacity(0.4),
                ),
                sigleItemBox("13","الطلبات المنتهية"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 1,
                  height: 25,
                  color: Colors.grey.withOpacity(0.4),
                ),
                sigleItemBox("0","تم إلغائها")],

            )
        ),
      ),
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
