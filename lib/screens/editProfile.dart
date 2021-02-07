import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zanad_app/components/test.dart';
import 'package:zanad_app/components/textfeild.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import 'package:zanad_app/config/server_addersses.dart';
import 'package:zanad_app/themes/characteristics.dart';
import '../themes/colors.dart';
import '../screens/home.dart';
class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String Id;
  getIdInState() async {
    await HelperFunctions.getUserIdSharedPreference().then((value){
      setState(() {
        Id = value;
        print("$Id id=");

      });
    });
  }
  @override
  void initState() {
    getIdInState();

    //  Profile();
    // TODO: implement initState
    super.initState();
  }
  String userImage;
  String name ;
  String absherNum;
  String email;
  String civilRegistry;
  String address;
  String base64Image;
  ServerAddresses serverAddresses=new ServerAddresses();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: appBar(),
      body: Stack(
        children: <Widget>[
          background(),
          ListView(
            children: <Widget>[
              bodyHome(),
              EditProfileBody(),
            ],
          ),
        ],
      ),

    );
  }
  Widget EditProfileBody(){

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),

            child: Material(
              elevation: 2,
              borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
              child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  height: MediaQuery.of(context).size.height*0.65,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                 child: Stack(
                   children: [
                    FutureBuilder<dynamic>(
                    future: serverAddresses.Profile(Id),
                    builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    HelperFunctions.saveUserNameSharedPreference(snapshot.data['info'][0]['FullName']);
                    name=snapshot.data['info'][0]['FullName'];
                    email=snapshot.data['info'][0]['Email'];
                    return Stack(
                    children: <Widget>[  ListView(
                       //crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text("الاسم"),
                         textFeild(hintText: "مصعب ابراهيم الغامدي",callback:(val){setState(() =>name=val);},label: snapshot.data['info'][0]['FullName'],),
                         SizedBox(height: 8,),
                         // Text("رقم أبشر"),
                         // Align(alignment: Alignment.centerLeft,
                         //     child: textFeild(hintText: "9587 5586 966+ ",callback:(val){setState(() =>absherNum=val);})),
                         SizedBox(height: 8,),
                         Text("البريد الإلكتروني"),
                         textFeild(hintText: "Musab12@gmail.com ",callback:(val){setState(() =>email=val);},label: snapshot.data['info'][0]['Email']),
                         SizedBox(height: 8,),
                         // Text("السجل المدني"),
                         // textFeild(hintText: " 458 585",callback:(val){setState(() =>civilRegistry=val);}),
                         SizedBox(height: 8,),
                         Text("العنوان"),
                         textFeild(hintText: " جدة-الرويس",callback:(val){setState(() =>address=val);},),


                       ],

                     )]);}
                else if (snapshot.hasError) {
                return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
                        ),

                     Positioned(
                      bottom: 10.0,
                       left: 1.0,
                       right: 1.0,
                       child:Center(child: Button(Id,name,"",email,absherNum,address,base64Image)),
                     )
                   ],
                 ),
    )));
  }
  Widget bodyHome(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Material(
        elevation: 2,
        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
        child: Container(
          decoration:Characteristics.boxDecoration,
          height: MediaQuery.of(context).size.height*0.2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(4),
          // color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("تعديل الملف الشخصي",style: TextStyle(fontSize: 14,color:Colors.black ),),
              SizedBox(height: 14,),
              test((val){
                setState(() {base64Image=val;});
              })

            ],
          ),

        ),
      ),
    );
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
  Widget background(){
    return  Container(
      height: MediaQuery.of(context).size.width*.15,
      decoration: BoxDecoration(
        color: themeColors.dark_green,
      ),
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
  Widget Button(String UserId, String FullName, String IdentityImg,String Email, String AbsherNumber,String City,String Image){
    return   InkWell(
      onTap:(){
        print(UserId);
        print(FullName);
        print(Image);
        print(AbsherNumber);
      ServerAddresses serverAddresses=new ServerAddresses();
      serverAddresses.updateProfile(UserId,FullName,IdentityImg,Email,AbsherNumber,City,Image);
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home("proflie")));
        // Navigator.popAndPushNamed(context, '/activateCode');
      } ,
      child: Container(
        height: 45,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color:Color(0xFF007A43) ,
        ),
        width: MediaQuery.of(context).size.width*0.7,
        padding: EdgeInsets.only(top: 5,bottom: 14),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Center(
          child: Text("التالي",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
