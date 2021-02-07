import 'package:flutter/material.dart';
import 'package:zanad_app/themes/colors.dart';
enum DialogAction { yes, abort }
final _controller = TextEditingController();


class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,
      Function(String) callback,
      ) async {

    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          //title: Text(title),
          content:  Container(
            height:MediaQuery.of(context).size.height*0.13 ,
            child: Column(
              children: <Widget>[
                Text("ادخل سبب الارجاع"),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  onChanged: (val){callback(val);},
                  autofocus: false,
                  keyboardType:TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "سبب الإرجاع",
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                  ),),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: FlatButton(
                color: themeColors.dark_green,
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: const Text('الاعتماد ',
                  style: TextStyle(
                    color: Colors.white,
                  ),),

              ),
            ),

          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}