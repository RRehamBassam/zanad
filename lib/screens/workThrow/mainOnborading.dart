
import 'package:flutter/material.dart';

import 'package:zanad_app/config/HelperFunctions.dart';
import '../home.dart';
import 'data.dart';
import 'Page_indicator.dart';



class My_App extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<My_App> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }
//vsync
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //     colors: [Colors.white, Color(0xFFFFFFFF)],
        //     tileMode: TileMode.clamp,
        //     begin: Alignment.topCenter,
        //     stops: [0.0, 1.0],
        //     end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        //backgroundColor:  Color(0xFF007A43),
        body: Container(
          padding: EdgeInsets.only(top: 110),
          decoration: BoxDecoration(
              image: DecorationImage(
              fit: BoxFit.fitHeight,
                  image: AssetImage("assets/Canvas.png",))
          ),
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PageView.builder(
                itemCount: pageList.length,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                    if (currentPage == pageList.length - 1) {
                      lastPage = true;
                      animationController.forward();
                    } else {
                      lastPage = false;
                      animationController.reset();
                    }
                    print(lastPage);
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      var page = pageList[index];
                      var delta;
                      var y = 1.0;

                      if (_controller.position.haveDimensions) {
                        delta = _controller.page - index;
                        y = 1 - delta.abs().clamp(0.0, 1.0);
                      }
                      return Stack(
                        children: <Widget>[

                        Container(

                          margin: EdgeInsets.symmetric(horizontal:30 ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/popup.png"))
                          ),),
                          Positioned(
                            top: -100,
                            right:0,
                            left:0,
                            bottom:0,
                            child:Container(
                              margin: EdgeInsets.symmetric(horizontal:30 ),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Center(child:Image.asset(page.imageUrl,scale: 1.8,),),
                                Container(
                                  margin: EdgeInsets.only(left: 12.0),
                                  height: 80.0,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 40.0, right: 15.0),
                                        child:new Text(
                                          page.title,textDirection: TextDirection.rtl,
                                          style: TextStyle(color: Color(0xFF008A4F),
                                            fontSize: 18.0,
                                            fontFamily:'Schyler',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 34.0, top:0.0),
                                  child: Transform(
                                    transform:
                                    Matrix4.translationValues(0, 50.0 * (1 - y), 0),
                                    child: Text(
                                      page.body,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'Schyler',
                                          color: Color(0xFF666666)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                          //   Center (child:Container(
                          //         width: 50.0,
                          //         child: PageIndicator(currentPage, pageList.length)),
                          // )
                          ],
                          ),
                            ),),
                        ],
                      );
                    },
                  );
                },
              ),



              Positioned(
                right: 15.0,
                left: 15.0,
                bottom: 30.0,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: lastPage
                      ?Center(child:  InkWell(
                    splashColor: Color(0xFF008C50).withOpacity(0.8),
                   child:Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color:Color(0xFF008C50),
                       border:Border.all(width: 2.0, color: const Color(0xFFFFFFFF)),
                     ) ,
                      //color: Color(0xFF007A43),
                  height: 48,
                  width: 175,
                  margin: EdgeInsets.symmetric(horizontal: 15),

                  child:  Center(
                    child: Text("إبدأ الأن", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'Schyler'),),
                  ),
                ),
                    onTap: () {
                      HelperFunctions.saveUserLoggedInSharedPreference(true);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_){
                            return Home("home");
                          }),(route)=> false
                      );
                     // Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home("home")));
                    },
                  ),)

                      : Center (child:Container(
                    //color: Colors.white,
                      height: 48,
                      width: 150,
                            child: PageIndicator(currentPage, pageList.length)),
                     ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
