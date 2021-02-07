import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:typed_data';

class test extends StatefulWidget {
  final Function(String) callback;

  test(this.callback);

  @override
  _CameraConnectState createState() => _CameraConnectState(callback);
}
class _CameraConnectState extends State<test> {
  final Function(String) callback;

  _CameraConnectState(this.callback);

  String base64Image;
  File image;
  File _image;
  SharedPreferences preferences;
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    preferences  = await SharedPreferences.getInstance();
    setState(() {
    //  HelperFunctions.saveUserPhotoSharedPreference(image);
      _image = image;
      base64Image = base64Encode(_image.readAsBytesSync());
      fileName = image.path.split('/').last;
      base64Image = base64Encode(_image.readAsBytesSync());
      HelperFunctions.saveUserImageSharedPreference(base64Image);
      callback("https://zenadapp.com/ZenadApi/Files/${fileName}");
    });
  }
  String userImage;
  Uint8List bytes;
  String fileName;
  getImageInState() async {
    await HelperFunctions.getUserImageSharedPreference().then((value){
      setState(() {
        userImage  = value;
        bytes = convert.base64.decode(userImage);
      });
    });
  }
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = image;
      fileName = image.path.split('/').last;
      base64Image = base64Encode(_image.readAsBytesSync());
      HelperFunctions.saveUserImageSharedPreference(base64Image);
      callback("https://api.zenadapp.com/Files/${fileName}");
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
    return
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
                print(base64Image);
              },
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 70.0,
                  height: 70.0,
                  fit: BoxFit.fill,
                ),
              )
                  : userImage==null? Stack(
                children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      elevation: 2,
                      child:  Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:  AssetImage('assets/profile.png',)
                            )),)
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: iconEditPhoto())
                ],
              ):ClipOval(
              // radius: 45,
              child: Image.memory(bytes,fit: BoxFit.fitWidth,height: 50.0,width: 50.0,),
          ),
            ),
          )

    ;
  }
}
Widget iconEditPhoto(){
  return   Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),

        color: Color(0xFF007A43)),
    child: Icon(Icons.camera_alt,color: Colors.white,size: 16,),
  );
}