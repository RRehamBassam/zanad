import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class Attachment extends StatefulWidget {
  String documentName;
  Function(String) callback;

  Attachment(this.documentName,this.callback);
  @override
  _AttachmentState createState() => _AttachmentState(documentName,callback);
}

class _AttachmentState extends State<Attachment> {


  String documentName;
  Function(String) callback;
  _AttachmentState(this.documentName,this.callback);
  File image;
  File _image;
  File tmpFile;
  String fileName;
  String base64Image;

  String error = 'Error';

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    setState(() {
      //  HelperFunctions.saveUserPhotoSharedPreference(image);
      _image = image;
      tmpFile=image;
      fileName = tmpFile.path.split('/').last;
      base64Image = base64Encode(_image.readAsBytesSync());
      callback(base64Image);
      callback("https://zenadapp.com/ZenadApi/Files/${fileName}");
    });
  }
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      tmpFile=image;
       fileName = tmpFile.path.split('/').last;
      base64Image = base64Encode(_image.readAsBytesSync());
      callback("https://zenadapp.com/ZenadApi/Files/${fileName}");
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  //connect camera
  cameraConnect() async {
    print('Picker is Called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
        _showPicker(context);
      },
      child: _image != null
      ?   Stack(
        children: <Widget>[Container(
          margin: EdgeInsets.only(top: 4,right: 4),
          width:70,
          child: Image.file(
          _image,
          width: 100.0,
          height: 90.0,
          fit: BoxFit.fill,
          ),
      ),
          Positioned(top: -6,right: -6,
              child: InkWell(onTap: ()=>setState(()=>_image=null),
                  child: Container(
                    width: 30,
                      padding: EdgeInsets.all(6) ,
                      child: add(Icon(Icons.clear,color: Colors.white,size: 16,),Colors.red)))),])
          :  Container(
//  height: 200,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child:
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    width:25,
                    margin: EdgeInsets.only(right: 4,bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))
                    ),
                    child:Center(child: Icon(Icons.photo_camera,color: Colors.grey[400],)
                    ) ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child:add(Icon(Icons.add,color: Colors.white,size: 12,),Color(0xFF007A43)) ,
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text(documentName,style: TextStyle(fontSize: documentName.length>12?11:12),),


            ///Image.asset("assets/photo-camera.png",width:20 ,height: 40.0,)
// SizedBox(height: 16,)
          ],
        ),

      )),
    );
  }


  Widget add(Icon icon,Color color){
    return   Container(

        //padding: EdgeInsets.all(0.1),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
    border: Border.all(width: 1,color: Colors.white),
    color: color),
        child: icon
    );
  }
}


