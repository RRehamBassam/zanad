import 'dart:async';
import 'package:zanad_app/screens/doneRep.dart';
import 'package:zanad_app/screens/requestnewTransaction.dart';

import './auth/activateCode.dart';
import './screens/workThrow/mainOnborading.dart';
import 'package:zanad_app/config/HelperFunctions.dart';
import './screens/home.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'auth/enterNoAbsher.dart';
import 'auth/loginScreen.dart';
import 'auth/registerScreen.dart';

// await translator.setNewLanguage(
// context,
// newLanguage:  'ar',
// );
void main() async {
  // if your flutter > 1.7.8 :  ensure flutter activated
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  ); // intialize

  runApp(LocalizedApp(child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'زناد Zanad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Schyler',
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF008C50),
        accentColor: Colors.grey[200],

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),

      routes: {
         '/home': (_) => Home("home"),
         '/login': (_) => new LoginScreen(),
        '/register': (_) => new registerScreen(),
       '/activateCode':(_) => new activaeCode(),
        '/requestNewTransactionextends'   :  (_) => new requestNewTransactionextends(),
        '/enterNoAbsher'   :  (_) => new enterNoAbsher(),
       // '/doneRep':  (_) => new doneRep(),

        // '/signup': (_) => new SignupScreen(),
        // '/forgot_password': (_) => new ForgotPassword(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userIsLoggedIn;



  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  void initState(){
    userIsLoggedIn=false;
    getLoggedInState();

    super.initState();
    start();
  }
  start()async{

    return Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_){
            return userIsLoggedIn != null ?  userIsLoggedIn ?Home("home") : My_App():My_App();//
          })
      );
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: 'ar',
      );
    });

    // TODO: implement build
    return  Scaffold(
      body: Container(
          width: double.infinity,
          child:Center(
            child:Image.asset("assets/splash.jpg",fit: BoxFit.fitHeight,height: MediaQuery.of(context).size.height,),// Text(translator.translate('appTitle')),//
          )),
    );


  }
}
