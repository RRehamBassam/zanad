import 'package:flutter/material.dart';
import 'package:zanad_app/themes/colors.dart';
enum DialogAction { yes, abort }
final _controller = TextEditingController();


class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,
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
          content: Text(
            'هل تريد إلغاء الطلب',
          ),
          actions: <Widget>[
            FlatButton(
              color: themeColors.dark_green,
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('لا',
                style: TextStyle(
                  color: Colors.white,
                ),),

            ),
            FlatButton(
              color: themeColors.dark_green,
              onPressed: () async=>{

                Navigator.of(context).pop(DialogAction.yes)},
              child: const Text(
                'نعم',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}