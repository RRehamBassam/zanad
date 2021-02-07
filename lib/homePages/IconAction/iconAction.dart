import 'package:flutter/material.dart';
class IconAction extends StatefulWidget {
  @override
  _IconActionState createState() => _IconActionState();
}

class _IconActionState extends State<IconAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
            onTap: ()=>{{setState(()=>{})},
              // Navigator.push(context, new MaterialPageRoute(builder: (context)=>new not()))
            },
            child: Icon(Icons.notifications_none,color: Colors.white,)));
  }
}
